# WARNING
**This repository is not maintained**

# Linux on Asus Flow x13 

With small tweaks almost everything (surprisingly touch, pen input and camera) works fine .
Notable exceptions is fingerprint.

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

## Tablet
Since kernel 5.14 accelerometer works and detects orientation but
SW_TABLET_MODE does not. Seams like tablet mode switch is required for Gnome to automatically rotate display and enable virtual keyboard.

For a linux kernel patch to fix this issue see: [https://github.com/IvanDovgal/asus-rog-flow-x13-tablet-mode](https://github.com/IvanDovgal/asus-rog-flow-x13-tablet-mode)
Installation instructions can be found [here](https://github.com/Quoteme/asus-rog-flow-x13-tablet-mode/tree/patch-1)

## Sound
Since kernel 5.14 sound output from the speakers work.
## Keyboard
Out of the box keyboard works. However, keyboard backlight may start blinking during sleep or not work after resume from sleep.

To fix keyboard backlight sleep issues install `misc/system-sleep/asus-flow-x13-keyboard.sleep` sleep script
```sh
sudo cp misc/system-sleep/asus-flow-x13-keyboard.sleep /usr/lib/systemd/system-sleep/
```

## GPU

### AMD iGPU
Works.

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
echo '#nvidia dGPU' > /etc/udev/rules.d/99-asus-flow-power.rules
echo 'ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{vendor}=="0x10de", ATTR{power/control}="auto"' >> /etc/udev/rules.d/99-asus-flow-power.rules
udevadm control --reload
```
