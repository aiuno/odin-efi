package efi

Text_Reset :: #type proc "std" (
	this: ^Simple_Text_Output_Protocol,
	extended_verification: bool,
) -> Status
Text_String :: #type proc "std" (this: ^Simple_Text_Output_Protocol, str: cstring16) -> Status
Text_Test_String :: #type proc "std" (this: ^Simple_Text_Output_Protocol, str: cstring16) -> Status
Text_Query_Mode :: #type proc "std" (
	this: ^Simple_Text_Output_Protocol,
	mode_number: uint,
	columns, rows: ^uint,
) -> Status
Text_Set_Mode :: #type proc "std" (this: ^Simple_Text_Output_Protocol, mode_number: uint) -> Status
Text_Set_Attribute :: #type proc "std" (
	this: ^Simple_Text_Output_Protocol,
	attribute: uint,
) -> Status
Text_Clear_Screen :: #type proc "std" (this: ^Simple_Text_Output_Protocol) -> Status
Text_Set_Cursor_Position :: #type proc "std" (
	this: ^Simple_Text_Output_Protocol,
	column, row: uint,
) -> Status
Text_Enable_Cursor :: #type proc "std" (
	this: ^Simple_Text_Output_Protocol,
	visible: bool,
) -> Status

// UNICODE DRAWING CHARACTERS
BOXDRAW_HORIZONTAL :: 0x2500
BOXDRAW_VERTICAL :: 0x2502
BOXDRAW_DOWN_RIGHT :: 0x250c
BOXDRAW_DOWN_LEFT :: 0x2510
BOXDRAW_UP_RIGHT :: 0x2514
BOXDRAW_UP_LEFT :: 0x2518
BOXDRAW_VERTICAL_RIGHT :: 0x251c
BOXDRAW_VERTICAL_LEFT :: 0x2524
BOXDRAW_DOWN_HORIZONTAL :: 0x252c
BOXDRAW_UP_HORIZONTAL :: 0x2534
BOXDRAW_VERTICAL_HORIZONTAL :: 0x253c

BOXDRAW_DOUBLE_HORIZONTAL :: 0x2550
BOXDRAW_DOUBLE_VERTICAL :: 0x2551
BOXDRAW_DOWN_RIGHT_DOUBLE :: 0x2552
BOXDRAW_DOWN_DOUBLE_RIGHT :: 0x2553
BOXDRAW_DOUBLE_DOWN_RIGHT :: 0x2554
BOXDRAW_DOWN_LEFT_DOUBLE :: 0x2555
BOXDRAW_DOWN_DOUBLE_LEFT :: 0x2556
BOXDRAW_DOUBLE_DOWN_LEFT :: 0x2557

BOXDRAW_UP_RIGHT_DOUBLE :: 0x2558
BOXDRAW_UP_DOUBLE_RIGHT :: 0x2559
BOXDRAW_DOUBLE_UP_RIGHT :: 0x255a
BOXDRAW_UP_LEFT_DOUBLE :: 0x255b
BOXDRAW_UP_DOUBLE_LEFT :: 0x255c
BOXDRAW_DOUBLE_UP_LEFT :: 0x255d

BOXDRAW_VERTICAL_RIGHT_DOUBLE :: 0x255e
BOXDRAW_VERTICAL_DOUBLE_RIGHT :: 0x255f
BOXDRAW_DOUBLE_VERTICAL_RIGHT :: 0x2560

BOXDRAW_VERTICAL_LEFT_DOUBLE :: 0x2561
BOXDRAW_VERTICAL_DOUBLE_LEFT :: 0x2562
BOXDRAW_DOUBLE_VERTICAL_LEFT :: 0x2563

BOXDRAW_DOWN_HORIZONTAL_DOUBLE :: 0x2564
BOXDRAW_DOWN_DOUBLE_HORIZONTAL :: 0x2565
BOXDRAW_DOUBLE_DOWN_HORIZONTAL :: 0x2566

BOXDRAW_UP_HORIZONTAL_DOUBLE :: 0x2567
BOXDRAW_UP_DOUBLE_HORIZONTAL :: 0x2568
BOXDRAW_DOUBLE_UP_HORIZONTAL :: 0x2569

BOXDRAW_VERTICAL_HORIZONTAL_DOUBLE :: 0x256a
BOXDRAW_VERTICAL_DOUBLE_HORIZONTAL :: 0x256b
BOXDRAW_DOUBLE_VERTICAL_HORIZONTAL :: 0x256c

// EFI Required Block Elements Code Chart
BLOCKELEMENT_FULL_BLOCK :: 0x2588
BLOCKELEMENT_LIGHT_SHADE :: 0x2591

// EFI Required Geometric Shapes Code Chart
GEOMETRICSHAPE_UP_TRIANGLE :: 0x25b2
GEOMETRICSHAPE_RIGHT_TRIANGLE :: 0x25ba
GEOMETRICSHAPE_DOWN_TRIANGLE :: 0x25bc
GEOMETRICSHAPE_LEFT_TRIANGLE :: 0x25c4

// EFI Required Arrow shapes
ARROW_UP :: 0x2191
ARROW_DOWN :: 0x2193

// Attributes
BLACK :: 0x00
BLUE :: 0x01
GREEN :: 0x02
CYAN :: 0x03
RED :: 0x04
MAGENTA :: 0x05
BROWN :: 0x06
LIGHTGRAY :: 0x07
BRIGHT :: 0x08
DARKGRAY :: (BLACK | BRIGHT)
LIGHTBLUE :: 0x09
LIGHTGREEN :: 0x0A
LIGHTCYAN :: 0x0B
LIGHTRED :: 0x0C
LIGHTMAGENTA :: 0x0D
YELLOW :: 0x0E
WHITE :: 0x0F

BACKGROUND_BLACK :: 0x00
BACKGROUND_BLUE :: 0x10
BACKGROUND_GREEN :: 0x20
BACKGROUND_CYAN :: 0x30
BACKGROUND_RED :: 0x40
BACKGROUND_MAGENTA :: 0x50
BACKGROUND_BROWN :: 0x60
BACKGROUND_LIGHTGRAY :: 0x70

SIMPLE_TEXT_OUTPUT_PROTOCOL_GUID :: Guid {
	0x387477c2,
	0x69c7,
	0x11d2,
	{0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b},
}

Simple_Text_Output_Protocol :: struct {
	reset:               Text_Reset,
	output_string:       Text_String,
	test_string:         Text_Test_String,
	query_mode:          Text_Query_Mode,
	set_mode:            Text_Set_Mode,
	set_attribute:       Text_Set_Attribute,
	clear_screen:        Text_Clear_Screen,
	set_cursor_position: Text_Set_Cursor_Position,
	enable_cursor:       Text_Enable_Cursor,
	mode:                Simple_Text_Output_Mode,
}

Simple_Text_Output_Mode :: struct {
	max_mode:       i32,
	mode:           i32,
	attribute:      i32,
	cursor_column:  i32,
	cursor_row:     i32,
	cursor_visible: bool,
}
