package efi

OPEN_PROTOCOL_BY_HANDLE_PROTOCOL :: 0x00000001
OPEN_PROTOCOL_GET_PROTOCOL :: 0x00000002
OPEN_PROTOCOL_TEST_PROTOCOL :: 0x00000004
OPEN_PROTOCOL_BY_CHILD_CONTROLLER :: 0x00000008
OPEN_PROTOCOL_BY_DRIVER :: 0x00000010
OPEN_PROTOCOL_EXCLUSIVE :: 0x00000020

Create_Event :: #type proc "std" (
	type: u32,
	notify_tpl: TPL,
	notify_proc: Event_Notify,
	notify_ctx: rawptr,
	event: ^Event,
) -> Status
Event_Notify :: #type proc "std" (event: Event, ctx: rawptr)
Create_Event_Ex :: #type proc "std" (
	type: u32,
	notify_tpl: TPL,
	notify_proc: Event_Notify,
	notify_ctx: rawptr,
	event_group: Guid,
	event: ^Event,
) -> Status
Close_Event :: #type proc "std" (event: Event) -> Status
Signal_Event :: #type proc "std" (event: Event) -> Status
Wait_For_Event :: #type proc "std" (number_of_events: uint, event: ^Event, index: ^uint) -> Status
Check_Event :: #type proc "std" (event: Event) -> Status
Set_Timer :: #type proc "std" (event: Event, type: Timer_Delay, tigger_time: u64) -> Status
Raise_TPL :: #type proc "std" (new_tpl: TPL) -> TPL
Restore_TPL :: #type proc "std" (old_tpl: TPL)
Allocate_Pages :: #type proc "std" (
	type: Allocate_Type,
	memory_type: Memory_Type,
	pages: uint,
	memory: ^Physical_Address,
) -> Status
Free_Pages :: #type proc "std" (memory: Physical_Address, pages: uint) -> Status
Get_Memory_Map :: #type proc "std" (
	memory_map_size: ^uint,
	memory_map: ^Memory_Descriptor,
	map_key, descriptor_size: ^uint,
	descriptor_version: ^u32,
) -> Status
Allocate_Pool :: #type proc "std" (pool_type: Memory_Type, size: uint, buffer: ^rawptr) -> Status
Free_Pool :: #type proc "std" (buffer: rawptr) -> Status
Install_Protocol_Interface :: #type proc "std" (
	handle: ^Handle,
	protocol: ^Guid,
	interface_type: Interface_Type,
	interface: rawptr,
) -> Status
Uninstall_Protocol_Interface :: #type proc "std" (
	handle: Handle,
	protocol: ^Guid,
	interface: rawptr,
) -> Status
Reinstall_Protocol_Interface :: #type proc "std" (
	handle: ^Handle,
	protocol: ^Guid,
	old_interface: rawptr,
	new_interface: rawptr,
) -> Status
Register_Protocol_Notify :: #type proc "std" (
	protocol: ^Guid,
	event: Event,
	registration: ^rawptr,
) -> Status
Locate_Handle :: #type proc "std" (
	search_type: Locate_Search_Type,
	protocol: ^Guid,
	buffer_size: ^uint,
	buffer: ^Handle,
) -> Status
Handle_Protocol :: #type proc "std" (handle: Handle, protocol: ^Guid, interface: ^rawptr) -> Status
Locate_Device_Path :: #type proc "std" (
	protocol: ^Guid,
	device_path: ^^Device_Path_Protocol,
	device: ^Handle,
) -> Status
Open_Protocol :: #type proc "std" (
	handle: Handle,
	protocol: ^Guid,
	interface: ^rawptr,
	agent_handle: Handle,
	controller_handle: Handle,
	attributes: u32,
) -> Status
Close_Protocol :: #type proc "std" (
	handle: Handle,
	protocol: ^Guid,
	agent_handle: Handle,
	controller_handle: Handle,
) -> Status
Open_Protocol_Information :: #type proc "std" (
	handle: Handle,
	protocol: ^Guid,
	entry_buffer: ^[^]Open_Protocol_Information_Entry,
	entry_count: uint,
) -> Status
Connect_Controller :: #type proc "std" (
	controller_handle: Handle,
	driver_image_handle: ^Handle,
	remaining_device_path: ^Device_Path_Protocol,
	recursive: bool,
) -> Status
Disconnect_Controller :: #type proc "std" (
	controller_handle, driver_image_handle, child_handle: Handle,
) -> Status
Protocols_Per_Handle :: #type proc "std" (
	handle: Handle,
	protocol_buffer: ^^[^]Guid,
	protocol_buffer_count: ^uint,
) -> Status
Locate_Handle_Buffer :: #type proc "std" (
	search_type: Locate_Search_Type,
	procotol: ^Guid,
	search_key: rawptr,
	no_handles: ^uint,
	buffer: ^[^]Handle,
) -> Status
Locate_Protocol :: #type proc "std" (
	protocol: ^Guid,
	registration: rawptr,
	interface: ^rawptr,
) -> Status
Install_Multiple_Protocol_Interfaces :: #type proc "std" (
	handle: ^Handle,
	#c_vararg interfaces: ..any,
) -> Status
Uninstall_Multiple_Protocol_Interfaces :: #type proc "std" (
	handle: Handle,
	#c_vararg interfaces: ..any,
) -> Status
Load_Image :: #type proc "std" (
	boot_policy: bool,
	parent_image_handle: Handle,
	device_path: ^Device_Path_Protocol,
	source_buffer: rawptr,
	source_size: uint,
	image_handle: ^Handle,
) -> Status
Start_Image :: #type proc "std" (
	image_handle: Handle,
	exit_data_size: ^uint,
	exit_data: ^cstring16,
) -> Status
Unload_Image :: #type proc "std" (image_handle: Handle) -> Status
Exit :: #type proc "std" (
	image_handle: Handle,
	exit_status: Status,
	exit_data_size: uint,
	exit_data: cstring16,
) -> Status
Exit_Boot_Services :: #type proc "std" (image_handle: Handle, map_key: uint) -> Status
Set_Watchdog_Timer :: #type proc "std" (
	timeout: uint,
	watchdog_code: u64,
	data_size: uint,
	watchdog_data: cstring16,
) -> Status
Stall :: #type proc "std" (microseconds: uint) -> Status
Copy_Mem :: #type proc "std" (destination, source: rawptr, length: uint)
Set_Mem :: #type proc "std" (buffer: rawptr, size: uint, value: u8)
Get_Next_Monotonic_Count :: #type proc "std" (count: ^u64) -> Status
Install_Configuration_Table :: #type proc "std" (guid: ^Guid, table: rawptr) -> Status
Calculate_Crc32 :: #type proc "std" (data: rawptr, data_size: uint, crc32: u32) -> Status

BOOT_SERVICES_SIGNATURE :: 0x56524553544f4f42
BOOT_SERVICES_REVISION :: SPECIFICATION_VERSION

Boot_Services :: struct {
	hdr:                                    Table_Header,
	// Task priority services
	raise_tpl:                              Raise_TPL,
	restore_tpl:                            Restore_TPL,
	// Memory services
	allocate_pages:                         Allocate_Pages,
	free_pages:                             Free_Pages,
	get_memory_map:                         Get_Memory_Map,
	allocate_pool:                          Allocate_Pool,
	free_pool:                              Free_Pool,
	// Event and timer services
	create_event:                           Create_Event,
	set_timer:                              Set_Timer,
	wait_for_event:                         Wait_For_Event,
	signal_event:                           Signal_Event,
	close_event:                            Close_Event,
	check_event:                            Check_Event,
	// Protocol handler services
	install_protocol_interface:             Install_Protocol_Interface,
	reinstall_protocol_interface:           Reinstall_Protocol_Interface,
	uninstall_protocol_interface:           Uninstall_Protocol_Interface,
	handle_protocol:                        Handle_Protocol,
	reserved:                               rawptr,
	register_protocol_notify:               Register_Protocol_Notify,
	locate_handle:                          Locate_Handle,
	locate_device_path:                     Locate_Device_Path,
	install_configuration_table:            Install_Configuration_Table,
	// Image services
	load_image:                             Load_Image,
	start_image:                            Start_Image,
	exit:                                   Exit,
	unload_image:                           Unload_Image,
	exit_boot_services:                     Exit_Boot_Services,
	// Misc services
	get_next_monotonic_count:               Get_Next_Monotonic_Count,
	stall:                                  Stall,
	set_watchdog_timer:                     Set_Watchdog_Timer,
	// DriverSupport services
	connect_controller:                     Connect_Controller,
	disconnect_controller:                  Disconnect_Controller,
	// Open and close protocol services
	open_protocol:                          Open_Protocol,
	close_protocol:                         Close_Protocol,
	open_protocol_information:              Open_Protocol_Information,
	// Library services
	protocols_per_handle:                   Protocols_Per_Handle,
	locate_handle_buffer:                   Locate_Handle_Buffer,
	locate_protocol:                        Locate_Protocol,
	install_multiple_protocol_interfaces:   Install_Multiple_Protocol_Interfaces,
	uninstall_multiple_protocol_interfaces: Uninstall_Multiple_Protocol_Interfaces,
	// 32-bit CRC services
	calculate_crc32:                        Calculate_Crc32,
	// Misc services
	copy_mem:                               Copy_Mem,
	set_mem:                                Set_Mem,
	create_event_ex:                        Create_Event_Ex,
}
