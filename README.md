# Linux on Asus Flow x13 

With small tweaks almost everything (surprisingly touch, pen input and camera) works fine .
Notable exceptions are resume from sleep and fingerprint.

While writing on this, power draw from battery (with terminal, vscode and chromium open) is between 6 and 10W.
CPU temperature is ~50C and fans are off.

To quickly install the fixes presented here one could
```sh
sudo sh install.sh
```

And to uninstall them
```sh
sudo sh uninstall.sh
```


## Keyboard
Out of the box keyboard works but Fn-Key and backlight do not.

Since 5.11 linux kernel support for Asus N-Key Keyboards but is missing usb device id.
To install the patched hid-asus for Flow x13 run
```sh
sudo dkms install drivers/hid
```

## GPU

### AMD iGPU
Integrated gpu requires linux firmware after 11.02.2021 (having "Green Sardine").

### Nvidia
Nouveau drivers hangs laptop at boot. It can be blacklisted by appending
`nouveau.blacklist=1` to kernel command line or by following commands as root
```sh
echo "blacklist nouveau" >  /etc/modprobe.d/asus-flow-x13-nouveau.conf
echo "alias nouveau off" >> /etc/modprobe.d/asus-flow-x13-nouveau.conf
```

Even if nouveau or nvidia is not loaded nvidia gpu will still consume ~10W of power.
We need to set power/control to auto to reduce power.

```sh
echo auto > /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/power/control
echo '#nvidia dGPU' > /etc/udev/rules.d/99-asus-flow-power.rules
echo 'ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{vendor}=="0x10de", ATTR{power/control}="auto"' >> /etc/udev/rules.d/99-asus-flow-power.rules
udevadm control --reload
```
