package efi

FILE_PROTOCOL_REVISION :: 0x00010000
FILE_PROTOCOL_REVISION2 :: 0x00020000
FILE_PROTOCOL_LATEST_REVISION :: FILE_PROTOCOL_REVISION2

File_Open :: #type proc "std" (
	this: ^File_Protocol,
	new_handle: ^^File_Protocol,
	file_name: cstring16,
	open_mode: u64,
	attributes: u64,
) -> Status
File_Close :: #type proc "std" (this: ^File_Protocol) -> Status
File_Delete :: #type proc "std" (this: ^File_Protocol) -> Status
File_Read :: #type proc "std" (this: ^File_Protocol, buffer_size: ^uint, buffer: rawptr) -> Status
File_Write :: #type proc "std" (this: ^File_Protocol, buffer_size: ^uint, buffer: rawptr) -> Status
File_Open_Ex :: #type proc "std" (
	this: ^File_Protocol,
	new_handle: ^^File_Protocol,
	file_name: cstring16,
	open_mode, attributes: u64,
	token: ^File_IO_Token,
) -> Status
File_Read_Ex :: #type proc "std" (this: ^File_Protocol, token: ^File_IO_Token) -> Status
File_Write_Ex :: #type proc "std" (this: ^File_Protocol, token: ^File_IO_Token) -> Status
File_Flush_Ex :: #type proc "std" (this: ^File_Protocol, token: ^File_IO_Token) -> Status
File_Set_Position :: #type proc "std" (this: ^File_Protocol, position: u64) -> Status
File_Get_Position :: #type proc "std" (this: ^File_Protocol, position: ^u64) -> Status
File_Get_Info :: #type proc "std" (
	this: ^File_Protocol,
	information_type: ^Guid,
	buffer_size: ^uint,
	buffer: rawptr,
) -> Status
File_Set_Info :: #type proc "std" (
	this: ^File_Protocol,
	information_type: ^Guid,
	buffer_size: uint,
	buffer: rawptr,
) -> Status
File_Flush :: #type proc "std" (this: ^File_Protocol) -> Status

File_Protocol :: struct {
	revision:     u64,
	open:         File_Open,
	close:        File_Close,
	delete:       File_Delete,
	read:         File_Read,
	write:        File_Write,
	get_position: File_Get_Position,
	set_position: File_Set_Position,
	get_info:     File_Get_Info,
	set_info:     File_Set_Info,
	flush:        File_Flush,
	// Added in revision 2
	open_ex:      File_Open_Ex,
	read_ex:      File_Read_Ex,
	write_ex:     File_Write_Ex,
	flush_ex:     File_Flush_Ex,
}

FILE_MODE_READ :: 0x0000000000000001
FILE_MODE_WRITE :: 0x0000000000000002
FILE_MODE_CREATE :: 0x8000000000000000

FILE_READ_ONLY :: 0x0000000000000001
FILE_HIDDEN :: 0x0000000000000002
FILE_SYSTEM :: 0x0000000000000004
FILE_RESERVED :: 0x0000000000000008
FILE_DIRECTORY :: 0x0000000000000010
FILE_ARCHIVE :: 0x0000000000000020
FILE_VALID_ATTR :: 0x0000000000000037

FILE_INFO_ID :: Guid{0x09576e92, 0x6d3f, 0x11d2, {0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b}}

File_Info :: struct {
	size:              u64,
	file_size:         u64,
	physical_size:     u64,
	create_time:       Time,
	last_access_time:  Time,
	modification_time: Time,
	attribute:         u64,
	file_name:         cstring16,
}

File_IO_Token :: struct {
	event:       Event,
	status:      Status,
	buffer_size: uint,
	buffer:      rawptr,
}
