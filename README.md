# Hand written EFI library for Odin
### ⚠️ Not finished! Some protocols are missing. Feel free to send a pull request if you get to it before I do.

![Screenshot](images/hellope.png)

## Quick start (🐧Linux)
Your main.odin file
```odin
package hellope

import "efi"

// We need to define these ourselves because these
// are stored in base/runtime/procs_windows_amd64.asm and
// `foreign import x "x.asm"` doesn't work when -build-mode:obj
@(export)
_tls_index: u32
@(export)
_fltused: i32 = 0x9875

// We set up a custom entry point which skips all Odin initialization.
@(export)
efi_main :: proc "std" (image_handle: efi.Handle, system_table: ^efi.System_Table) -> efi.Status {
	efi.init(image_handle, system_table) or_return

	efi.print("Hellope!\r\n")

	return .Success
}
```
And to build
```sh
odin build . \
	-default-to-panic-allocator \
	-no-thread-local \
	-no-crt \
	-build-mode:obj \
	-target:freestanding_amd64_win64

lld -flavor link \
	./*.obj \
	-subsystem:efi_application \
	-nodefaultlib \
	-dll \
	-entry:efi_main \
	-out:hellope.efi
```
Then use something like [uefi-run](https://github.com/richard-w/uefi-run) to test it
```sh
uefi-run hellope.efi -b PATH_TO_OVMF.fd
```
