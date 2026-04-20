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

LOAD_FILE2_PROTOCOL_GUID :: Guid {
	0x4006c0c1,
	0xfcb3,
	0x403e,
	{0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d},
}

// The only difference is in the returned status of load_file()
Load_File2_Protocol :: distinct Load_File_Protocol
