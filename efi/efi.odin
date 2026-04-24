package efi

Guid :: struct {
	d1:     u32,
	d2, d3: u16,
	d4:     [8]byte,
}

//Status :: distinct uint
Handle :: distinct rawptr
Event :: distinct Handle
LBA :: distinct u64
TPL :: distinct uint
Mac_Address :: distinct [32]byte
IPv4_Address :: distinct [4]byte
IPv6_Address :: distinct [16]byte
IP_Address :: union {
	IPv4_Address,
	IPv6_Address,
}

Status :: enum uint {
	Success = 0,
	Warn_Unknown_Glyph,
	Warn_Delete_Failure,
	Warn_Write_Failure,
	Warn_Buffer_Too_Small,
	Warn_Stale_Data,
	Warn_File_System,
	Warn_Reset_Required,
	Load_Error = 0x8000000000000001,
	Invalid_Parameter,
	Unsupported,
	Bad_Buffer_Size,
	Buffer_Too_Small,
	Not_Ready,
	Device_Error,
	Write_Protected,
	Out_Of_Resources,
	Volume_Corrupted,
	Volume_Full,
	No_Media,
	Media_Changed,
	Not_Found,
	Access_Denied,
	No_Response,
	No_Mapping,
	Timeout,
	Not_Started,
	Already_Started,
	Aborted,
	ICMP_Error,
	TFTP_Error,
	Protocol_Error,
	Incompatible_Version,
	Security_Violation,
	CRC_Error,
	End_Of_Media,
	End_Of_File,
	Invalid_Language,
	Compromised_Data,
	IP_Address_Conflict,
	Http_Error,
}

Physical_Address :: distinct uintptr
Virtual_Address :: distinct Physical_Address

Table_Header :: struct {
	signature:   u64,
	revision:    u32,
	header_size: u32,
	crc32:       u32,
	reserved:    u32,
}

SYSTEM_TABLE_SIGNATURE :: 0x5453595320494249
SYSTEM_TABLE_REVISION_2_100 :: ((2 << 16) | (100))
SYSTEM_TABLE_REVISION_2_90 :: ((2 << 16) | (90))
SYSTEM_TABLE_REVISION_2_80 :: ((2 << 16) | (80))
SYSTEM_TABLE_REVISION_2_70 :: ((2 << 16) | (70))
SYSTEM_TABLE_REVISION_2_60 :: ((2 << 16) | (60))
SYSTEM_TABLE_REVISION_2_50 :: ((2 << 16) | (50))
SYSTEM_TABLE_REVISION_2_40 :: ((2 << 16) | (40))
SYSTEM_TABLE_REVISION_2_31 :: ((2 << 16) | (31))
SYSTEM_TABLE_REVISION_2_30 :: ((2 << 16) | (30))
SYSTEM_TABLE_REVISION_2_20 :: ((2 << 16) | (20))
SYSTEM_TABLE_REVISION_2_10 :: ((2 << 16) | (10))
SYSTEM_TABLE_REVISION_2_00 :: ((2 << 16) | (00))
SYSTEM_TABLE_REVISION_1_10 :: ((1 << 16) | (10))
SYSTEM_TABLE_REVISION_1_02 :: ((1 << 16) | (02))
SPECIFICATION_VERSION :: SYSTEM_TABLE_REVISION
SYSTEM_TABLE_REVISION :: SYSTEM_TABLE_REVISION_2_100

System_Table :: struct {
	hdr:                     Table_Header,
	firmware_vendor:         cstring16,
	firmware_revision:       u32,
	console_in_handle:       Handle,
	con_in:                  ^Simple_Text_Input_Protocol,
	console_out_handle:      Handle,
	con_out:                 ^Simple_Text_Output_Protocol,
	standard_error_handle:   Handle,
	std_err:                 ^Simple_Text_Output_Protocol,
	runtime_services:        ^Runtime_Services,
	boot_services:           ^Boot_Services,
	number_of_table_entries: uint,
	configuration_table:     ^Configuration_Table,
}

Configuration_Table :: struct {
	vendor_guid:  Guid,
	vendor_table: rawptr,
}

EVT_TIMER :: 0x80000000
EVT_RUNTIME :: 0x40000000

EVT_NOTIFY_WAIT :: 0x00000100
EVT_NOTIFY_SIGNAL :: 0x00000200

EVT_SIGNAL_EXIT_BOOT_SERVICES :: 0x00000201
EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE :: 0x00000202

Timer_Delay :: enum uint {
	Cancel,
	Periodic,
	Relative,
}

Allocate_Type :: enum uint {
	Any_Pages,
	Max_Address,
	Address,
	Max,
}

Memory_Type :: enum uint {
	Reserved,
	Loader_Code,
	Loader_Data,
	Boot_Services_Code,
	Boot_Services_Data,
	Runtime_Services_Code,
	Runtime_Services_Data,
	Conventional,
	Unusable,
	ACPI_Reclaim,
	ACPI_NVS,
	Mapped_IO,
	Mapped_IO_Port_Space,
	Pal_Code,
	Persistent,
	Unaccepted,
	Max,
}

// Attributes for memory descriptor
MEMORY_UC :: 0x0000000000000001
MEMORY_WC :: 0x0000000000000002
MEMORY_WT :: 0x0000000000000004
MEMORY_WB :: 0x0000000000000008
MEMORY_UCE :: 0x0000000000000010
MEMORY_WP :: 0x0000000000001000
MEMORY_RP :: 0x0000000000002000
MEMORY_XP :: 0x0000000000004000
MEMORY_NV :: 0x0000000000008000
MEMORY_MORE_RELIABLE :: 0x0000000000010000
MEMORY_RO :: 0x0000000000020000
MEMORY_SP :: 0x0000000000040000
MEMORY_CPU_CRYPTO :: 0x0000000000080000
MEMORY_HOT_PLUGGABLE :: 0x0000000000100000
MEMORY_RUNTIME :: 0x8000000000000000
MEMORY_ISA_VALID :: 0x4000000000000000
MEMORY_ISA_MASK :: 0x0FFFF00000000000

MEMORY_DESCRIPTOR_VERSION :: 1

Memory_Descriptor :: struct {
	type:            u32,
	physical_start:  Physical_Address,
	virtual_start:   Virtual_Address,
	number_of_pages: u64,
	attribute:       u64,
}

Interface_Type :: enum uint {
	Native,
}

Locate_Search_Type :: enum uint {
	All_Handles,
	By_Register_Notify,
	By_Protocol,
}

Open_Protocol_Information_Entry :: struct {
	agent_handle, controller_handle: Handle,
	attributes, open_count:          u32,
}

TIME_ADJUST_DAYLIGHT :: 0x01
TIME_IN_DAYLIGHT :: 0x02
UNSPECIFIED_TIMEZONE :: 0x07ff

Time :: struct {
	year:       u16,
	month:      u8,
	day:        u8,
	hour:       u8,
	minute:     u8,
	second:     u8,
	_:          u8, // Padding
	nanosecond: u32,
	timezone:   i16,
	daylight:   u8,
	_:          u8, // Padding
}

Time_Capabilities :: struct {
	resolution:   u32,
	accuracy:     u32,
	sets_to_zero: bool,
}

Win_Certificate :: struct {
	length:           u32,
	revision:         u16,
	certificate_type: u16,
	//UINT8           bCertificate[ANYSIZE_ARRAY];
}

Win_Certificate_Uefi_Guid :: struct {
	hdr:       Win_Certificate,
	cert_type: Guid,
	cert_data: [^]u8,
}

Variable_Flag :: enum u32 {
	Non_Volatile,
	Bootservice_Access,
	Runtime_Access,
	Hardware_Error_Record,
	HR,
	Time_Based_Authenticated_Write_Access,
	Append_Write,
	Enhanced_Authenticated_Access,
}

Variable_Flags :: bit_set[Variable_Flag;u32]

VARIABLE_AUTHENTICATION_3_CERT_ID_SHA256 :: 1
VARIABLE_AUTHENTICATION_3_TIMESTAMP_TYPE :: 1
VARIABLE_AUTHENTICATION_3_NONCE_TYPE :: 2

HARDWARE_ERROR_VARIABLE :: Guid {
	0x414E6BDD,
	0xE47B,
	0x47cc,
	{0xB2, 0x44, 0xBB, 0x61, 0x02, 0x0C, 0xF5, 0x16},
}

Variable_Authentication_3_Cert_Id :: struct {
	type:    u8,
	id_size: u32,
	// id: [id_size]u8
}

Variable_Authentication_2 :: struct {
	timestamp: Time,
	auth_info: Win_Certificate_Uefi_Guid,
}

Variable_Authentication_3 :: struct {
	version:       u8,
	type:          u8,
	metadata_size: u32,
	flags:         Variable_Flags,
}

Variable_Authentication_3_Nonce :: struct {
	nonce_size: u32,
	// nonce: [nonce_size]u8
}

OPTIONAL_PTR :: 0x0000001

Reset_Type :: enum uint {
	Cold,
	Warm,
	Shutdown,
	Platform_Specific,
}

CAPSULE_FLAGS_PERSIST_ACROSS_RESET :: 0x00010000
CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE :: 0x00020000
CAPSULE_FLAGS_INITIATE_RESET :: 0x00040000

Capsule_Block_Descriptor :: struct {
	length: u64,
	onion:  struct #raw_union {
		// Whoever came up with this at the UEFI board should get a promotion :)))
		data_block:           Physical_Address,
		continuation_pointer: Physical_Address,
	},
}

Capsule_Header :: struct {
	capsule_guid:       Guid,
	header_size:        u32,
	flags:              u32,
	capsule_image_size: u32,
}

Capsule_Table :: struct {
	capsule_array_number: u32,
	capsule_ptr:          [^]rawptr,
}

MEMORY_RANGE_CAPSULE_GUID :: Guid {
	0xde9f0ec,
	0x88b6,
	0x428f,
	{0x97, 0x7a, 0x25, 0x8f, 0x1d, 0xe, 0x5e, 0x72},
}

Memory_Range :: struct {
	address: Physical_Address,
	length:  u64,
}

Memory_Range_Capsule :: struct {
	header:                   Capsule_Header,
	os_requested_memory_type: u32,
	number_of_memory_ranges:  u64,
	memory_ranges:            [^]Memory_Range,
}

Memory_Range_Capsule_Result :: struct {
	firmware_memory_requirement: u64,
	number_of_memory_ranges:     u64,
}

List_Entry :: struct {
	next: ^List_Entry,
	prev: ^List_Entry,
}
