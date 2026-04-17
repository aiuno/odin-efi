package efi

Input_Reset :: #type proc "std" (
	this: ^Simple_Text_Input_Protocol,
	extended_verification: bool,
) -> Status
Input_Read_Key :: #type proc "std" (this: ^Simple_Text_Input_Protocol, key: ^Input_Key) -> Status

Input_Key :: struct {
	scancode:     u16,
	unicode_char: u16,
}

SIMPLE_TEXT_INPUT_PROTOCOL_GUID :: Guid {
	0x387477c1,
	0x69c7,
	0x11d2,
	{0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b},
}

Simple_Text_Input_Protocol :: struct {
	reset:           Input_Reset,
	read_key_stroke: Input_Read_Key,
	wait_for_key:    Event,
}
