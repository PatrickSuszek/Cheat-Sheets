1. sudo blkid -o list -w /dev/null
   - Shows all connected devices
2. sudo mount <usb path> /media/usbstick
   - Mounts the usb partition like dev/sda1 to /media/usbstick
3. sudo umount /media/usbstick
4. sudo eject /dev/sda1