#!/bin/sh

#install patched keyboard module
sudo dkms install drivers/hid

#blacklist nouveau
echo "blacklist nouveau" >  /etc/modprobe.d/asus-flow-x13-nouveau.conf
echo "alias nouveau off" >> /etc/modprobe.d/asus-flow-x13-nouveau.conf

#stop nvidia power draw
echo auto > /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/power/control
#persist using udev rule
echo '#nvidia dGPU' > /etc/udev/rules.d/99-asus-flow-power.rules
echo 'ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{vendor}=="0x10de", ATTR{power/control}="auto"' >> /etc/udev/rules.d/99-asus-flow-power.rules
udevadm control --reload

#ssd
echo "\n#ssd" >> /etc/udev/rules.d/99-asus-flow-power.rules
echo 'ACTION=="add", SUBSYSTEM=="pci", DRIVER=="nvme", TEST=="power/control", ATTR{power/control}="auto"' >> /etc/udev/rules.d/99-asus-flow-power.rules


echo "Please rebuild your initramfs and reboot"
