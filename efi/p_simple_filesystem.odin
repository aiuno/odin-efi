package efi

Simple_File_System_Protocol_Open_Volume :: #type proc "std" (
	this: ^Simple_File_System_Protocol,
	root: ^^File_Protocol,
) -> Status

SIMPLE_FILE_SYSTEM_PROTOCOL_GUID :: Guid {
	0x0964e5b22,
	0x6459,
	0x11d2,
	{0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b},
}

SIMPLE_FILE_SYSTEM_PROTOCOL_REVISION :: 0x00010000

Simple_File_System_Protocol :: struct {
	revision:    u64,
	open_volume: Simple_File_System_Protocol_Open_Volume,
}
