package efi

LOADED_IMAGE_PROTOCOL_GUID :: Guid {
	0x5B1B31A1,
	0x9562,
	0x11d2,
	{0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B},
}

LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID :: Guid {
	0xbc62157e,
	0x3e33,
	0x4fec,
	{0x99, 0x20, 0x2d, 0x3b, 0x36, 0xd7, 0x50, 0xdf},
}

LOADED_IMAGE_PROTOCOL_REVISION :: 0x1000

Loaded_Image_Protocol :: struct {
	revision:          u32,
	parent_handle:     Handle,
	system_table:      ^System_Table,
	device_handle:     Handle,
	file_path:         ^Device_Path_Protocol,
	reserved:          rawptr,
	load_options_size: u32,
	load_options:      rawptr,
	image_base:        rawptr,
	image_size:        u64,
	image_code_type:   Memory_Type,
	image_data_type:   Memory_Type,
	unload:            Unload_Image, // Proc comes from boot_services.odin
}
