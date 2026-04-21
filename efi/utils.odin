package efi

args: []cstring16

@(private)
lip: ^Loaded_Image_Protocol
@(private)
system_table: ^System_Table

init :: proc "contextless" (image: Handle, systab: ^System_Table) -> Status {
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

	system_table = systab

	lip_guid := LOADED_IMAGE_PROTOCOL_GUID
	system_table.boot_services.handle_protocol(image, &lip_guid, cast(^rawptr)&lip) or_return

	shp: ^Shell_Parameters_Protocol
	shp_guid := SHELL_PARAMETERS_PROTOCOL_GUID
	status := system_table.boot_services.open_protocol(
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
		status = system_table.boot_services.open_protocol(
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

clear_screen :: proc "contextless" () -> Status {
	return system_table.con_out->clear_screen()
}

print :: proc "contextless" (str: cstring16) -> Status {
	return system_table.con_out->output_string(str)
}

is_error :: #force_inline proc "contextless" (status_code: $Status) -> bool {
	return uint(status_code) >= 0x8000000000000000
}

// Do not use BACKGROUND_xxx values with this.
text_attr :: #force_inline proc "contextless" (foreground, background: $uint) -> uint {
	return foreground | (background << 4)
}
