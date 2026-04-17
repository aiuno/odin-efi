package efi

Get_Variable :: #type proc "std" (
	variable_name: cstring16,
	vendor_guid: ^Guid,
	attributes: u32,
	data_size: uint,
	data: rawptr,
) -> Status
Get_Next_Variable_Name :: #type proc "std" (
	variable_name_size: ^uint,
	variable_name: cstring16,
	vendor_guid: ^Guid,
) -> Status
Set_Variable :: #type proc "std" (
	variable_name: cstring16,
	vendor_guid: ^Guid,
	attributes: u32,
	data_size: uint,
	data: rawptr,
) -> Status
Query_Variable_Info :: #type proc "std" (
	attributes: u32,
	maximum_variable_storage_size: ^u64,
	remaining_variable_storage_size: ^u64,
	maximum_variable_size: ^u64,
) -> Status
Get_Time :: #type proc "std" (time: ^Time, capabilities: ^Time_Capabilities) -> Status
Set_Time :: #type proc "std" (time: ^Time) -> Status
Get_Wakeup_Time :: #type proc "std" (enabled, pending: ^bool, time: ^Time) -> Status
Set_Wakeup_Time :: #type proc "std" (enable: bool, time: ^Time) -> Status
Set_Virtual_Address_Map :: #type proc "std" (
	memory_map_size: uint,
	descriptor_size: uint,
	descriptor_version: u32,
	virtual_map: ^Memory_Descriptor,
) -> Status
Convert_Pointer :: #type proc "std" (debug_disposition: uint, address: ^rawptr) -> Status
Reset_System :: #type proc "std" (
	reset_type: Reset_Type,
	reset_status: Status,
	data_size: uint,
	reset_data: rawptr,
)
Get_Next_High_Monotonic_Count :: #type proc "std" (high_count: ^u32) -> Status
Update_Capsule :: #type proc "std" (
	capsule_header_array: ^[^]Capsule_Header,
	capsule_count: uint,
	scatter_gather_list: Physical_Address,
)
Query_Capsule_Capabilities :: #type proc "std" (
	capsule_header_array: ^[^]Capsule_Header,
	capsule_count: uint,
	maximum_capsule_size: ^u64,
	reset_type: ^Reset_Type,
) -> Status

RUNTIME_SERVICES_SIGNATURE :: 0x56524553544e5552
RUNTIME_SERVICES_REVISION :: SPECIFICATION_VERSION

Runtime_Services :: struct {
	hdr:                           Table_Header,
	// Time services
	get_time:                      Get_Time,
	set_time:                      Set_Time,
	get_wakeup_time:               Get_Wakeup_Time,
	set_wakeup_time:               Set_Wakeup_Time,
	// Virtual memory services
	set_virtual_address_map:       Set_Virtual_Address_Map,
	convert_pointer:               Convert_Pointer,
	// Variable services
	get_variable:                  Get_Variable,
	get_next_variable_name:        Get_Next_Variable_Name,
	set_variable:                  Set_Variable,
	// Misc services
	get_next_high_monotonic_count: Get_Next_High_Monotonic_Count,
	reset_system:                  Reset_System,
	// UEFI 2.0 capsule services
	update_capsule:                Update_Capsule,
	query_capsule_capabilities:    Query_Capsule_Capabilities,
	// Misc UEFI 2.0 service
	query_variable_info:           Query_Variable_Info,
}
