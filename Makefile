obj-m += hid-asus.o
obj-m += snd-hda-codec-realtek.o

hid-asus-objs := drivers/hid/hid-asus.o
snd-hda-codec-realtek-objs := sound/pci/hda/patch_realtek.o

ifeq ($(origin KERNELRELEASE), undefined)
  KERNELRELEASE := $(shell uname -r)
endif

.PHONY: all
all:
	$(MAKE) -C /lib/modules/$(KERNELRELEASE)/build M=$(shell pwd) modules

clean:
	$(MAKE) -C /lib/modules/$(KERNELRELEASE)/build M=$(shell pwd) clean
