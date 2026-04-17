package efi

SHELL_PARAMETERS_PROTOCOL_GUID :: Guid {
	0x752f3136,
	0x4e16,
	0x4fdc,
	{0xa2, 0x2a, 0xe5, 0xf4, 0x68, 0x12, 0xf4, 0xca},
}

Shell_Parameters_Protocol :: struct {
	argv:   [^]cstring16,
	argc:   uint,
	stdin:  Shell_File_Handle,
	stdout: Shell_File_Handle,
	stderr: Shell_File_Handle,
}
