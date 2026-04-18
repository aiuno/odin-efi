package efi

Load_File :: #type proc "std" (
	this: ^Load_File_Protocol,
	file_path: ^Device_Path_Protocol,
	boot_policy: bool,
	buffer_size: ^uint,
	buffer: rawptr,
) -> Status

LOAD_FILE_PROTOCOL_GUID :: Guid {
	0x56EC3091,
	0x954C,
	0x11d2,
	{0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b},
}

Load_File_Protocol :: struct {
	load_file: Load_File,
}

// The only difference is in the return status of load_file()
Load_File2_Protocol :: distinct Load_File_Protocol
