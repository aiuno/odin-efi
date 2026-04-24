#+private
package efi

import "base:runtime"
import "core:fmt"
import "core:slice"

args: []cstring16

@(private)
g_lip: ^Loaded_Image_Protocol
@(private)
g_systab: ^System_Table

foreign {
	efi_main :: proc "odin" () ---
}

@(export)
_tls_index: u32
@(export)
_fltused: i32 = 0x9875

@(link_name = "_DllMainCRTStartup", linkage = "strong", require)
bootstrap :: proc "std" (image_handle: Handle, systab: ^System_Table) -> Status {
	context = default_context()
	init(image_handle, systab) or_return
	#force_no_inline runtime._startup_runtime()
	efi_main()
	#force_no_inline runtime._cleanup_runtime()
	return .Success
}

init :: proc (image: Handle, systab: ^System_Table) -> Status {
	// Make sure SSE is enabled. Some firmwares don't do that apparently
	asm(){
		`.intel_syntax noprefix
		mov rax, cr0
		and ax, 0xfffb
		or  ax, 0x0002
		mov cr0, rax
		mov rax, cr4
		or  ax, 3<<9
		mov cr4, rax`,""
	}()

	// Should never happen, but if it does we are prepared
	if image == nil ||
	   systab == nil ||
	   systab.boot_services == nil ||
	   systab.boot_services.handle_protocol == nil ||
	   systab.boot_services.open_protocol == nil ||
	   systab.boot_services.allocate_pool == nil ||
	   systab.boot_services.free_pool == nil {
		return .Unsupported
	}

	g_systab = systab

	lip_guid := LOADED_IMAGE_PROTOCOL_GUID
	g_systab.boot_services.handle_protocol(image, &lip_guid, cast(^rawptr)&g_lip) or_return

	shp: ^Shell_Parameters_Protocol
	shp_guid := SHELL_PARAMETERS_PROTOCOL_GUID
	status := g_systab.boot_services.open_protocol(
		image,
		&shp_guid,
		cast(^rawptr)&shp,
		image,
		nil,
		{.Get},
	)
	if !is_error(status) && shp != nil {
		args = shp.argv[:shp.argc]
	} else {
		// Fallback to Shell 1.0
		shi: ^Shell_Interface_Protocol
		shi_guid := SHELL_INTERFACE_PROTOCOL_GUID
		status = g_systab.boot_services.open_protocol(
			image,
			&shi_guid,
			cast(^rawptr)&shi,
			image,
			nil,
			{.Get},
		)
		if !is_error(status) && shi != nil {
			args = shi.argv[:shi.argc]
		}
	}

	return .Success
}

default_assertion_failure_proc :: proc(prefix, message: string, loc: runtime.Source_Code_Location) -> ! {
	str := fmt.aprintf("%s(%d:%d) %s: %s\r\n", loc.file_path, loc.line, loc.column, prefix, message)

	g_systab.con_out->set_attribute(text_attr(WHITE, RED))
	g_systab.con_out->output_string(str_to_cwstr(str))
	g_systab.con_out->set_attribute(0)

	g_systab.boot_services.stall(10 * 1000 * 1000)
	g_systab.runtime_services.reset_system(.Warm, .Aborted, 0, nil)
}

default_context :: proc "contextless" () -> runtime.Context {
	return {
		allocator = pool_allocator(),
		temp_allocator = runtime.nil_allocator(),
		logger = {procedure = runtime.default_logger_proc},
		random_generator = runtime.default_random_generator(),
		assertion_failure_proc = default_assertion_failure_proc,
	}
}

@(require_results)
pool_allocator :: proc "contextless" () -> runtime.Allocator {
	return {procedure = pool_allocator_proc}
}

pool_allocator_proc :: proc(
	allocator_data: rawptr,
	mode: runtime.Allocator_Mode,
	size, alignment: int,
	old_memory: rawptr,
	old_size: int,
	loc := #caller_location,
) -> (buffer: []u8, error: runtime.Allocator_Error) {
	// This check is not 100% reliable, but there is no "real" way...
	// If we try to touch the memory after exiting boot services it
	// will crash either way, but it's nice to report why
	if g_systab.boot_services == nil {
		panic("Cannot allocate memory after boot service exit")
	}

	Header :: struct {
		original_ptr: rawptr,
		size:         int,
	}

	aligned_alloc :: proc(size, alignment: int, zero_memory := true) -> ([]u8, runtime.Allocator_Error) {
		fixed_align := alignment
		if fixed_align < size_of(rawptr) {
			fixed_align = size_of(rawptr)
		}

		header_size := size_of(Header)
		total := size + fixed_align + header_size

		base := pool_alloc(total, false)
		if base == nil {
			return nil, .Out_Of_Memory
		}

		// Align AFTER header
		ptr := uintptr(base) + uintptr(header_size)
		aligned := (ptr + uintptr(fixed_align - 1)) & ~(uintptr(fixed_align - 1))

		header := (^Header)(aligned - uintptr(header_size))
		header.original_ptr = base
		header.size = size

		if zero_memory {
			g_systab.boot_services.set_mem(rawptr(aligned), uint(size), 0)
		}

		return slice.bytes_from_ptr(rawptr(aligned), size), nil
	}

	aligned_free :: proc(p: rawptr) {
		if p == nil {
			return
		}

		header_size := size_of(Header)
		header := (^Header)(uintptr(p) - uintptr(header_size))

		pool_free(header.original_ptr)
	}

	aligned_resize :: proc(
		p: rawptr,
		old_size: int,
		new_size: int,
		alignment: int,
		zero_memory := true,
	) -> ([]u8, runtime.Allocator_Error) {
		if p == nil {
			return aligned_alloc(new_size, alignment, zero_memory)
		}

		new_mem, err := aligned_alloc(new_size, alignment, zero_memory)
		if err != nil {
			return nil, err
		}

		runtime.mem_copy_non_overlapping(raw_data(new_mem), p, min(old_size, new_size))

		aligned_free(p)

		return new_mem, nil
	}

	switch mode {
	case .Alloc, .Alloc_Non_Zeroed:
		return aligned_alloc(size, alignment, mode == .Alloc)

	case .Free:
		aligned_free(old_memory)

	case .Free_All:
		return nil, .Mode_Not_Implemented

	case .Resize, .Resize_Non_Zeroed:
		return aligned_resize(old_memory, old_size, size, alignment, mode == .Resize)

	case .Query_Features:
		set := (^runtime.Allocator_Mode_Set)(old_memory)
		if set != nil {
			set^ = {.Alloc, .Alloc_Non_Zeroed, .Free, .Resize, .Resize_Non_Zeroed, .Query_Features}
		}
		return nil, nil

	case .Query_Info:
		return nil, .Mode_Not_Implemented
	}

	return nil, nil
}

pool_alloc :: proc "contextless" (size: int, zero_memory := true) -> (new: rawptr) {
	if g_systab.boot_services.allocate_pool(
		   g_lip.image_data_type if g_lip != nil else .Loader_Data,
		   uint(size),
		   &new,
	   ) != .Success {
		return nil
	}

	if zero_memory {
		g_systab.boot_services.set_mem(new, uint(size), 0)
	}

	return
}

pool_resize :: proc "contextless" (ptr: rawptr, new_size, old_size: int) -> (new: rawptr) {
	if ptr == nil {
		new = pool_alloc(new_size)
	} else {
		if old_size < new_size {
			if new = pool_alloc(new_size); new == nil {
				return nil
			}

			g_systab.boot_services.copy_mem(new, ptr, uint(old_size))
			g_systab.boot_services.free_pool(ptr)
		} else {
			new = ptr
		}
	}

	return
}

pool_free :: proc "contextless" (ptr: rawptr) {
	g_systab.boot_services.free_pool(ptr)
}
