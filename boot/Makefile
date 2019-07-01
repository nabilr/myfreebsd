
include common.mk

CFLAGS= -c   -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -DEFI_FUNCTION_WRAPPER
INCLUDE = -I  /usr/include/efi
INCLUDE += -I /usr/include/efi/x86_64


LD_FLAGS=/usr/lib/crt0-efi-x86_64.o -nostdlib -znocombreloc  
LD_FLAGS+=-T /usr/lib/elf_x86_64_efi.lds -shared   -Bsymbolic -L /usr/lib
LD_FLAGS+= -l:libgnuefi.a   -l:libefi.a     

OBJCOPY_FLAGS=-j .text -j .sdata  -j .data  -j .dynamic  -j .dynsymi
OBJCOPY_FLAGS+= -j .rel  -j .rela   -j .reloc   --target=efi-app-x86_64 


$(OBJTOP)/boot/boot.efi: $(OBJTOP)/boot/boot.so
	objcopy	$(OBJCOPY_FLAGS)  $(OBJTOP)/boot/boot.so $(OBJTOP)/boot/boot.efi

$(OBJTOP)/boot/boot.so: $(OBJTOP)/boot/boot.o
	 ld $(OBJTOP)/boot/boot.o $(LD_FLAGS) -o $(OBJTOP)/boot/boot.so
	
	

$(OBJTOP)/boot/boot.o:	boot.c
	echo $(CURDIR)
	echo $(OBJTOP)
	gcc $(CFLAGS) $(INCLUDE) boot.c   -o $(OBJTOP)/boot/boot.o
