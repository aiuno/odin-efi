package hellope

import "../../efi"

@(export) // This export is important! The library calls this when init is done.
efi_main :: proc() {
	efi.println("Hellope!")
}
