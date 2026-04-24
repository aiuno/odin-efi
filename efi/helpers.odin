package efi

import "base:runtime"
import "core:strings"
import "core:unicode/utf16"

str_to_cwstr :: proc(str: string, buffer_size := 256) -> (cwstr: cstring16) {
	wbuf := make([]u16, buffer_size) or_else panic("Allocation error")
	n := utf16.encode_string(wbuf, str)
	wbuf[n] = 0

	(transmute(^runtime.Raw_Cstring16)&cwstr).data = &wbuf[0]
	return
}

clear_screen :: proc "contextless" () -> Status {
	return g_systab.con_out->clear_screen()
}

print :: proc (str: string) -> Status {
	cwstr := str_to_cwstr(str)
	defer delete(cwstr)

	return g_systab.con_out->output_string(cwstr)
}

println :: proc (str: string) -> Status {
	cat_str := strings.concatenate({str, "\r\n"}) or_else panic("Allocation error")
	defer delete(cat_str)
	cwstr := str_to_cwstr(cat_str)
	defer delete(cwstr)

	return g_systab.con_out->output_string(cwstr)
}

is_error :: #force_inline proc "contextless" (status_code: $Status) -> bool {
	return uint(status_code) >= 0x8000000000000000
}

// Do not use BACKGROUND_xxx values with this.
text_attr :: #force_inline proc "contextless" (foreground, background: uint) -> uint {
	return foreground | (background << 4)
}
