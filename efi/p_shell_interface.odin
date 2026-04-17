package efi

SHELL_INTERFACE_PROTOCOL_GUID :: Guid {
	0x47c7b223,
	0xc42a,
	0x11d2,
	{0x8e, 0x57, 0x0, 0xa0, 0xc9, 0x69, 0x72, 0x3b},
}

Shell_Interface_Protocol :: struct {
	image_handle:          Handle,
	info:                  ^Loaded_Image_Protocol,
	argv:                  [^]cstring16,
	argc:                  uint,
	redir_argv:            [^]cstring16,
	redir_argc:            uint,
	stdin, stdout, stderr: ^File_Protocol,
	arg_info:              ^Shell_Arg_Info,
	echo_on:               bool,
}

Shell_Arg_Info_Type :: enum u32 {
	Is_Quoted,
	Partially_Quoted,
	First_Half_Quoted,
	First_Char_Is_Esc,
}

Shell_Arg_Info_Types :: bit_set[Shell_Arg_Info_Type;u32]

Shell_Arg_Info :: struct {
	attributes: Shell_Arg_Info_Types,
}
