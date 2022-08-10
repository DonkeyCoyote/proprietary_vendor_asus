#!/vendor/bin/sh

type=`getprop persist.asus.audbg_station`

if [ "$type" == "0" ]; then
	echo 0 > /sys/class/ec_i2c/dongle/device/uart
elif [ "$type" == "1" ]; then
	echo 1 > /sys/class/ec_i2c/dongle/device/uart
fi
