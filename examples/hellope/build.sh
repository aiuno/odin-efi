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

rm ./*.obj ./hellope.lib
