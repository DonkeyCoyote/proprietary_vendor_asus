#!/vendor/bin/sh

# Set selinux
echo 1 > /sys/fs/selinux/log
sleep 1

panic_prop=`getprop vendor.asus.triggerpanic`

if [ "$panic_prop" == "1" ]; then
	echo "[Debug] LogTool Trigger Panic" > /proc/asusevtlog
	sleep 2
	echo panic > /proc/asusdebug-prop
else
	exit
fi
