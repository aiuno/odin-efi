package efi

Shell_File_Handle :: distinct rawptr
Shell_Device_Name_Flags :: distinct u32

Shell_Batch_Is_Active :: #type proc "std" () -> bool
Shell_Close_File :: #type proc "std" (file_handle: Shell_File_Handle) -> Status
Shell_Create_File :: #type proc "std" (
	file_name: cstring16,
	file_attribs: u64,
	file_handle: Shell_File_Handle,
) -> Status
Shell_Delete_File :: #type proc "std" (file_handle: Shell_File_Handle) -> Status
Shell_Delete_File_By_Name :: #type proc "std" (file_name: cstring16) -> Status
Shell_Disable_Page_Break :: #type proc "std" ()
Shell_Enable_Page_Break :: #type proc "std" ()
Shell_Execute :: #type proc "std" (
	parent_image_handle: ^Handle,
	command_line: cstring16,
	environment: [^]cstring16,
	status_code: ^Status,
) -> Status
Shell_Find_Files :: #type proc "std" (
	file_pattern: cstring16,
	file_list: ^^Shell_File_Info,
) -> Status
Shell_Find_Files_In_Dir :: #type proc "std" (
	file_dir_handle: Shell_File_Handle,
	file_list: ^^Shell_File_Info,
) -> Status
Shell_Flush_File :: #type proc "std" (file_handle: Shell_File_Handle) -> Status
Shell_Free_File_List :: #type proc "std" (file_list: ^^Shell_File_Info) -> Status
Shell_Get_Alias :: #type proc "std" (alias: cstring16, volatile: ^bool) -> cstring16
Shell_Get_Cur_Dir :: #type proc "std" (file_system_mapping: cstring16) -> cstring16
Shell_Get_Device_Name :: #type proc "std" (
	device_handle: Handle,
	flags: Shell_Device_Name_Flags,
	language: cstring,
	best_device_name: ^cstring16,
) -> Status
Shell_Get_Device_Path_From_Map :: #type proc "std" (mapping: cstring16) -> ^Device_Path_Protocol
Shell_Get_Device_Path_From_File_Path :: #type proc "std" (path: cstring16) -> ^Device_Path_Protocol
Shell_Get_Env :: #type proc "std" (name: cstring16) -> cstring16
Shell_Get_Env_Ex :: #type proc "std" (name: cstring16, attributes: ^u32) -> cstring16
Shell_Get_File_Info :: #type proc "std" (file_handle: Shell_File_Handle) -> ^File_Info
Shell_Get_File_Path_From_Device_Path :: #type proc "std" (path: ^Device_Path_Protocol) -> cstring16
Shell_Get_File_Position :: #type proc "std" (
	file_handle: Shell_File_Handle,
	position: ^u64,
) -> Status
Shell_Get_File_Size :: #type proc "std" (file_handle: Shell_File_Handle, size: ^u64) -> Status
Shell_Get_Guid_From_Name :: #type proc "std" (guid_name: cstring16, guid: ^Guid) -> Status
Shell_Get_Guid_Name :: #type proc "std" (guid: ^Guid, guid_name: ^cstring16) -> Status
Shell_Get_Help_Text :: #type proc "std" (
	command: cstring16,
	sections: cstring16,
	help_text: ^cstring16,
) -> Status
Shell_Get_Map_From_Device_Path :: #type proc "std" (
	device_path: ^^Device_Path_Protocol,
) -> cstring16
Shell_Get_Page_Break :: #type proc "std" () -> bool
Shell_Is_Root_Shell :: #type proc "std" () -> bool
Shell_Open_File_By_Name :: #type proc "std" (
	file_name: cstring16,
	file_handle: ^Shell_File_Handle,
	open_mode: u64,
) -> Status
Shell_Open_File_List :: #type proc "std" (
	path: cstring16,
	open_mode: u64,
	file_list: ^^Shell_File_Info,
) -> Status
Shell_Open_Root :: #type proc "std" (
	device_path: ^Device_Path_Protocol,
	file_handle: ^Shell_File_Handle,
) -> Status
Shell_Open_Root_By_Handle :: #type proc "std" (
	device_handle: Handle,
	file_handle: ^Shell_File_Handle,
) -> Status
Shell_Read_File :: #type proc "std" (
	file_handle: Shell_File_Handle,
	read_size: ^uint,
	buffer: rawptr,
) -> Status
Shell_Register_Guid_Name :: #type proc "std" (guid: ^Guid, guid_name: cstring16) -> Status
Shell_Remove_Dup_In_File_List :: #type proc "std" (file_list: ^^Shell_File_Info) -> Status
Shell_Set_Alias :: #type proc "std" (command, alias: cstring16, replace, volatile: bool) -> Status
Shell_Set_Cur_Dir :: #type proc "std" (file_system, dir: cstring16) -> Status
Shell_Set_Env :: #type proc "std" (name, value: cstring16, volatile: bool) -> Status
Shell_Set_File_Info :: #type proc "std" (
	file_handle: Shell_File_Handle,
	file_info: ^File_Info,
) -> Status
Shell_Set_File_Position :: #type proc "std" (
	file_handle: Shell_File_Handle,
	position: u64,
) -> Status
Shell_Set_Map :: #type proc "std" (
	device_path: ^Device_Path_Protocol,
	mapping: cstring16,
) -> Status
Shell_Write_File :: #type proc "std" (
	file_handle: Shell_File_Handle,
	buffer_size: ^uint,
	buffer: rawptr,
) -> Status

SHELL_PROTOCOL_GUID :: Guid {
	0x6302d008,
	0x7f9b,
	0x4f30,
	{0x87, 0xac, 0x60, 0xc9, 0xfe, 0xf5, 0xda, 0x4e},
}

Shell_Protocol :: struct {
	execute:                        Shell_Execute,
	get_env:                        Shell_Get_Env,
	set_env:                        Shell_Set_Env,
	get_alias:                      Shell_Get_Alias,
	set_alias:                      Shell_Set_Alias,
	get_help_text:                  Shell_Get_Help_Text,
	get_device_path_from_map:       Shell_Get_Device_Path_From_Map,
	get_map_from_device_path:       Shell_Get_Map_From_Device_Path,
	get_device_path_from_file_path: Shell_Get_Device_Path_From_File_Path,
	get_file_path_from_device_path: Shell_Get_File_Path_From_Device_Path,
	set_map:                        Shell_Set_Map,
	//
	get_cur_dir:                    Shell_Get_Cur_Dir,
	set_cur_dir:                    Shell_Set_Cur_Dir,
	open_file_list:                 Shell_Open_File_List,
	free_file_list:                 Shell_Free_File_List,
	remove_dup_in_file_list:        Shell_Remove_Dup_In_File_List,
	//
	batch_is_active:                Shell_Batch_Is_Active,
	is_root_shell:                  Shell_Is_Root_Shell,
	enable_page_break:              Shell_Enable_Page_Break,
	disable_page_break:             Shell_Disable_Page_Break,
	get_page_break:                 Shell_Get_Page_Break,
	get_device_name:                Shell_Get_Device_Name,
	//
	get_file_info:                  Shell_Get_File_Info,
	set_file_info:                  Shell_Set_File_Info,
	open_file_by_name:              Shell_Open_File_By_Name,
	close_file:                     Shell_Close_File,
	create_file:                    Shell_Create_File,
	read_file:                      Shell_Read_File,
	delete_file:                    Shell_Delete_File,
	delete_file_by_name:            Shell_Delete_File_By_Name,
	get_file_position:              Shell_Get_File_Position,
	set_file_position:              Shell_Set_File_Position,
	flush_file:                     Shell_Flush_File,
	find_files:                     Shell_Find_Files,
	find_files_in_dir:              Shell_Find_Files_In_Dir,
	get_file_size:                  Shell_Get_File_Size,
	//
	open_root:                      Shell_Open_Root,
	open_root_by_handle:            Shell_Open_Root_By_Handle,
	//
	execution_break:                Event,
	//
	major_version, minor_version:   u32,
	register_guid_name:             Shell_Register_Guid_Name,
	get_guid_name:                  Shell_Get_Guid_Name,
	get_guid_from_name:             Shell_Get_Guid_From_Name,
	//
	get_env_ex:                     Shell_Get_Env_Ex,
}

Shell_File_Info :: struct {
	link:      List_Entry,
	status:    Status,
	full_name: cstring16,
	file_name: cstring16,
	handle:    Shell_File_Handle,
	info:      ^File_Info,
}
