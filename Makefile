obj-m += drivers/hid/hid-asus.o

ifeq ($(origin KERNELRELEASE), undefined)
  KERNELRELEASE := $(shell uname -r)
endif

.PHONY: all
all:
	$(MAKE) -C /lib/modules/$(KERNELRELEASE)/build M=$(shell pwd) modules

clean:
	$(MAKE) -C /lib/modules/$(KERNELRELEASE)/build M=$(shell pwd) clean
