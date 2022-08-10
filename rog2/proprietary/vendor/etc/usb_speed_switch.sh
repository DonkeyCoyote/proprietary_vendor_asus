#!/vendor/bin/sh

speed=`getprop vendor.asus.usb.speed`

LOG_TAG="usb_speed_switch"

echo "$LOG_TAG:[USB] set usb1&usb2 speed : $speed" > /dev/kmsg

if [ "$speed" == "2" ]; then
		echo high > /sys/devices/platform/soc/a800000.ssusb/speed
		echo high > /sys/devices/platform/soc/a600000.ssusb/speed
elif [ "$speed" == "3" ]; then
		echo ssp > /sys/devices/platform/soc/a800000.ssusb/speed
		echo ssp > /sys/devices/platform/soc/a600000.ssusb/speed
fi
