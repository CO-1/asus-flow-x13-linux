# Linux on Asus Flow x13 

Everything here asumes Linux kernel 5.11 or newer.

## Keyboard
Out of the box keyboard works but Fn-Key and backlight do not.

Since 5.11 linux kernel support for Asus N-Key Keyboards but is missing usb device id.
To install the patched hid-asus for Flow x13 run
```sh
sudo dkms install drivers/hid
```
