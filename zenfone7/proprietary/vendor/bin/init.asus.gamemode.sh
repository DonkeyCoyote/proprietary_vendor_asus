#!/vendor/bin/sh
game_mode_type=`getprop vendor.asus.gamingtype`
#rotation_type=`getprop vendor.screen.rotation`

if [ "$game_mode_type" = "1" ];then
	echo 1 > /sys/bus/i2c/devices/i2c-4/4-0038/game_mode
	echo "[Focal][Touch] enter in gaming mode" >> /dev/kmsg
	echo 1 > /sys/bus/i2c/devices/i2c-4/4-0038/touch_report_rate
	#if [ "$rotation_type" = "90" ];then
	#	echo 2 > /sys/bus/i2c/devices/i2c-4/4-0038/rotation_type
	#	echo "[Touch]in gaming mode and rotation = 90" >> /dev/kmsg
	#elif [ "$rotation_type" = "270" ];then
	#	echo 1 > /sys/bus/i2c/devices/i2c-4/4-0038/rotation_type
	#	echo "[Touch]in gaming mode and rotation = 270" >> /dev/kmsg
	#else
	#	echo "[Touch]in gaming mode but not rotation " >> /dev/kmsg
	#fi
else
	echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/game_mode
	#echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/rotation_type
	echo "[Focal][Touch] not in gaming mode" >> /dev/kmsg
	echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/touch_report_rate
fi



