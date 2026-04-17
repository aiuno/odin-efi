package hellope

import "../../efi"

// We need to define these ourselves (on linux at least) because
// these are stored in base/runtime/procs_windows_amd64.asm and
// `foreign import x "x.asm"` doesn't work when -build-mode:obj
@(export)
_tls_index: u32
@(export)
_fltused: i32 = 0x9875

// We set up a custom entry point which skips all Odin initialization.
@(export)
efi_main :: proc "std" (image_handle: efi.Handle, system_table: ^efi.System_Table) -> efi.Status {
	efi.init(image_handle, system_table) or_return

	efi.print("Hellope!\r\n")

	return .Success
}
