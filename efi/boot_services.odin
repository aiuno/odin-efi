package efi

Create_Event :: #type proc "std" (
	type: u32, // In
	notify_tpl: TPL, // In
	notify_proc: Event_Notify, // In
	notify_ctx: rawptr, // In
	event: ^Event, // Out
) -> Status
Event_Notify :: #type proc "std" (
	event: Event, // In
	ctx: rawptr, // In
)
Create_Event_Ex :: #type proc "std" (
	type: u32, // In
	notify_tpl: TPL, // In
	notify_proc: Event_Notify, // In
	notify_ctx: rawptr, // In
	event_group: Guid, // In
	event: ^Event, // Out
) -> Status
Close_Event :: #type proc "std" (
	event: Event, // In
) -> Status
Signal_Event :: #type proc "std" (
	event: Event, // In
) -> Status
Wait_For_Event :: #type proc "std" (
	number_of_events: uint, // In
	event: ^Event, // In
	index: ^uint, // Out
) -> Status
Check_Event :: #type proc "std" (
	event: Event, // In
) -> Status
Set_Timer :: #type proc "std" (
	event: Event, // In
	type: Timer_Delay, // In
	tigger_time: u64, // In
) -> Status
Raise_TPL :: #type proc "std" (
	new_tpl: TPL, // In
) -> TPL
Restore_TPL :: #type proc "std" (
	old_tpl: TPL, // In
)
Allocate_Pages :: #type proc "std" (
	type: Allocate_Type, // In
	memory_type: Memory_Type, // In
	pages: uint, // In
	memory: ^Physical_Address, // In
) -> Status
Free_Pages :: #type proc "std" (
	memory: Physical_Address, // In
	pages: uint, // In
) -> Status
Get_Memory_Map :: #type proc "std" (
	memory_map_size: ^uint, // In Out
	memory_map: ^Memory_Descriptor, // Out
	map_key, descriptor_size: ^uint, // Out
	descriptor_version: ^u32, // Out
) -> Status
Allocate_Pool :: #type proc "std" (
	pool_type: Memory_Type, // In
	size: uint, // In
	buffer: ^rawptr, // Out
) -> Status
Free_Pool :: #type proc "std" (
	buffer: rawptr, // In
) -> Status
Install_Protocol_Interface :: #type proc "std" (
	handle: ^Handle, // In
	protocol: ^Guid, // In
	interface_type: Interface_Type, // In
	interface: rawptr, // In
) -> Status
Uninstall_Protocol_Interface :: #type proc "std" (
	handle: Handle, // In
	protocol: ^Guid, // In
	interface: rawptr, // In
) -> Status
Reinstall_Protocol_Interface :: #type proc "std" (
	handle: ^Handle, // In
	protocol: ^Guid, // In
	old_interface: rawptr, // In
	new_interface: rawptr, // In
) -> Status
Register_Protocol_Notify :: #type proc "std" (
	protocol: ^Guid, // In
	event: Event, // In
	registration: ^rawptr, // Out
) -> Status
Locate_Handle :: #type proc "std" (
	search_type: Locate_Search_Type, // In
	protocol: ^Guid, // In Optional
	search_key: rawptr, // In Optional
	buffer_size: ^uint, // In Out
	buffer: ^Handle, // Out
) -> Status
Handle_Protocol :: #type proc "std" (
	handle: Handle, // In
	protocol: ^Guid, // In
	interface: ^rawptr, // Out
) -> Status
Locate_Device_Path :: #type proc "std" (
	protocol: ^Guid, // In
	device_path: ^^Device_Path_Protocol, // In
	device: ^Handle, // Out
) -> Status
Open_Protocol :: #type proc "std" (
	handle: Handle, // In
	protocol: ^Guid, // In
	interface: ^rawptr, // Out Optional
	agent_handle: Handle, // In
	controller_handle: Handle, // In
	attributes: Open_Protocol_Attributes, // In
) -> Status
Close_Protocol :: #type proc "std" (
	handle: Handle, // In
	protocol: ^Guid, // In
	agent_handle: Handle, // In
	controller_handle: Handle, // In
) -> Status
Open_Protocol_Information :: #type proc "std" (
	handle: Handle, // In
	protocol: ^Guid, // In
	entry_buffer: ^[^]Open_Protocol_Information_Entry, // Out
	entry_count: uint, // Out
) -> Status
Connect_Controller :: #type proc "std" (
	controller_handle: Handle, // In
	driver_image_handle: ^Handle, // In Optional
	remaining_device_path: ^Device_Path_Protocol, // In Optional
	recursive: bool, // In
) -> Status
Disconnect_Controller :: #type proc "std" (
	controller_handle: Handle, // In
	driver_image_handle: Handle, // In Optional
	child_handle: Handle, // In Optional
) -> Status
Protocols_Per_Handle :: #type proc "std" (
	handle: Handle, // In
	protocol_buffer: ^^[^]Guid, // Out
	protocol_buffer_count: ^uint, // Out
) -> Status
Locate_Handle_Buffer :: #type proc "std" (
	search_type: Locate_Search_Type,
	procotol: ^Guid, // In Optional
	search_key: rawptr, // In Optional
	no_handles: ^uint, // Out
	buffer: ^[^]Handle, // Out
) -> Status
Locate_Protocol :: #type proc "std" (
	protocol: ^Guid, // In
	registration: rawptr, // In Optional
	interface: ^rawptr, // Out
) -> Status
Install_Multiple_Protocol_Interfaces :: #type proc "std" (
	handle: ^Handle, // In Out
	#c_vararg interfaces: ..any,
) -> Status
Uninstall_Multiple_Protocol_Interfaces :: #type proc "std" (
	handle: Handle, // In
	#c_vararg interfaces: ..any,
) -> Status
Load_Image :: #type proc "std" (
	boot_policy: bool, // In
	parent_image_handle: Handle, // In
	device_path: ^Device_Path_Protocol, // In Optional
	source_buffer: rawptr, // In Optional
	source_size: uint, // In
	image_handle: ^Handle, // Out
) -> Status
Start_Image :: #type proc "std" (
	image_handle: Handle, // In
	exit_data_size: ^uint, // Out
	exit_data: ^cstring16, // Out Optional
) -> Status
Unload_Image :: #type proc "std" (
	image_handle: Handle, // In
) -> Status
Exit :: #type proc "std" (
	image_handle: Handle, // In
	exit_status: Status, // In
	exit_data_size: uint, // In
	exit_data: cstring16, // In Optional
) -> Status
Exit_Boot_Services :: #type proc "std" (
	image_handle: Handle, // In
	map_key: uint, // In
) -> Status
Set_Watchdog_Timer :: #type proc "std" (
	timeout: uint, // In
	watchdog_code: u64, // In
	data_size: uint, // In
	watchdog_data: cstring16, // In Optional
) -> Status
Stall :: #type proc "std" (
	microseconds: uint, // In
) -> Status
Copy_Mem :: #type proc "std" (
	destination: rawptr, // In
	source: rawptr, // In
	length: uint, // In
)
Set_Mem :: #type proc "std" (
	buffer: rawptr, // In
	size: uint, // In
	value: u8, // In
)
Get_Next_Monotonic_Count :: #type proc "std" (
	count: ^u64, // Out
) -> Status
Install_Configuration_Table :: #type proc "std" (
	guid: ^Guid, // In
	table: rawptr, // In
) -> Status
Calculate_Crc32 :: #type proc "std" (
	data: rawptr, // In
	data_size: uint, // In
	crc32: ^u32, // Out
) -> Status

Open_Protocol_Attribute :: enum u32 {
	By_Handle,
	Get,
	Test,
	By_Child_Controller,
	By_Driver,
	Exclusive,
}

Open_Protocol_Attributes :: bit_set[Open_Protocol_Attribute;u32]

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
