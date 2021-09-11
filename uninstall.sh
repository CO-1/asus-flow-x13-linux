#!/bin/sh

rm /etc/modprobe.d/asus-flow-x13-nouveau.conf
rm /etc/udev/rules.d/99-asus-flow-power.rules
dkms remove hid-asus-flow-x13/1.0 --all

rm /usr/lib/systemd/system-sleep/asus-flow-x13-keyboard.sleep

echo "Please rebuild your initramfs and reboot"