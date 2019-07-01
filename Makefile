
#https://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile
#@ used if we dont want echo the unix command


INCLUDE_DIR=$(CURDIR)/share/mk

SUBDIRS = boot

.PHONY: subdirs $(SUBDIRS)
	
SRCDIR=$(CURDIR)

include $(INCLUDE_DIR)/common.mk


all:	setup subdirs uefi.img 



subdirs: $(SUBDIRS)


export 
$(SUBDIRS):
	 $(MAKE) -C $@ -I $(INCLUDE_DIR)

.PHONY: setup
setup:
	mkdir -p $(OBJTOP)/boot


uefi.img: $(OBJTOP)/uefi.img


$(OBJTOP)/uefi.img: $(OBJTOP)/boot/boot.efi
	dd if=/dev/zero of=$(OBJTOP)/uefi.img bs=512 count=93750
	parted $(OBJTOP)/uefi.img -s -a minimal mklabel gpt
	parted $(OBJTOP)/uefi.img -s -a minimal mkpart EFI FAT16 2048s 93716s
	parted $(OBJTOP)/uefi.img -s -a minimal toggle 1 boot
	dd if=/dev/zero of=/tmp/part.img bs=512 count=91669
	mformat -i /tmp/part.img -h 32 -t 32 -n 64 -c 1
	mcopy -i /tmp/part.img $(OBJTOP)/boot/boot.efi ::
	dd if=/tmp/part.img of=$(OBJTOP)/uefi.img bs=512 count=91669 seek=2048 conv=notrunc





clean:
	rm -rf $(OBJTOP)
