#!/vendor/bin/sh

echo "[latch_sensor] update_threshold start++++++" > /dev/kmsg

if [ -f "/vendor/factory/X" ];then
	X_threshold_factory=`cat /vendor/factory/X`
	echo "[latch_sensor] X_threshold_factory=$X_threshold_factory" > /dev/kmsg
else
	echo "[latch_sensor] /vendor/factory/X not exist!" > /dev/kmsg
	exit
fi


if [ -f "/vendor/factory/Y" ];then
	Y_threshold_factory=`cat /vendor/factory/Y`
	echo "[latch_sensor] Y_threshold_factory=$Y_threshold_factory" > /dev/kmsg
else
	echo "[latch_sensor] /vendor/factory/Y not exist!" > /dev/kmsg
	exit
fi


if [ -f "/sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/X1_threshold" ];then
	echo "$X_threshold_factory" > /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/X1_threshold
	if [ $? == 0 ];then
		X1_threshold_cat=`cat /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/X1_threshold`
		echo "[latch_sensor] X1_threshold value:$X1_threshold_cat" > /dev/kmsg
	else
		echo "[latch_sensor] echo X_threshold_factory failed" > /dev/kmsg
		exit
	fi
		
else
	echo "[latch_sensor] /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/X1_threshold not exist!" > /dev/kmsg
fi

if [ -f "/sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/Y1_threshold" ];then
	echo "$Y_threshold_factory" > /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/Y1_threshold
	if [ $? == 0 ];then
		Y1_threshold_cat=`cat /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/Y1_threshold`
		echo "[latch_sensor] Y1_threshold value:$Y1_threshold_cat" > /dev/kmsg
	else
		echo "[latch_sensor] echo Y_threshold_factory failed" > /dev/kmsg
		exit
	fi
else
	echo "[latch_sensor] /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/Y1_threshold not exist!" > /dev/kmsg
	exit
fi

if [ -f "/sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/trigger_update" ];then
	echo "1" > /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/trigger_update
	if [ $? == 0 ];then
		echo "[latch_sensor] trigger_update success" > /dev/kmsg
	else
		echo "[latch_sensor] trigger_update failed" > /dev/kmsg
		exit
	fi
else
	echo "[latch_sensor] /sys/bus/i2c/drivers/hall_sensor2/0-000d/hall_sensor2/trigger_update not exist!" > /dev/kmsg
	exit
fi

echo "[latch_sensor] update_threshold ended------" > /dev/kmsg

