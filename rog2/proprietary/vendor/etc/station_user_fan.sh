#!/vendor/bin/sh

dongle_type=`getprop vendor.asus.dongletype`
fan_type=`getprop persist.sys.asus.userfan`
micfansettings_type=`getprop persist.asus.micfansettings`
mic_type=`getprop sys.asus.fan.mic`
setprop vendor.fan.rpm "none"

function enable_mic(){
	echo 0 > /sys/class/ec_i2c/dongle/device/duty
	echo "[STATION_FAN][USER]enable_mic after sys.asus.fan.mic changed" > /dev/kmsg
}

function disable_mic(){
	fan_type=`getprop persist.sys.asus.userfan`
	if [ "$fan_type" == "0" ]; then
		echo 0 > /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][USER]disable fan" > /dev/kmsg
	elif [ "$fan_type" == "1" ]; then
		echo 42 >  /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][USER]fan_type 1 : low 42" > /dev/kmsg
	elif [ "$fan_type" == "2" ]; then		
		echo 50 > /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][USER]fan_type 2 : medium 46 " > /dev/kmsg
	elif [ "$fan_type" == "3" ]; then
		echo 55 > /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][USER]fan_type 3 : high 50 " > /dev/kmsg
	elif [ "$fan_type" == "4" ]; then
		echo 70 > /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][USER]fan_type 4 : turbo 55" > /dev/kmsg
	elif [ "$fan_type" == "auto" ]; then
		setprop persist.asus.tempfan 1
		echo "[STATION_FAN][AUTO]thermal fan will be set auto" > /dev/kmsg
	elif [ "$fan_type" == "csc_test" ]; then
		echo 70 > /sys/class/ec_i2c/dongle/device/duty
		sleep 2
		rpm=`cat /sys/class/ec_i2c/dongle/device/rpm`
		setprop vendor.fan.rpm "$rpm"
	fi
}


if [ "$dongle_type" == "2" ]; then
	if [ "$micfansettings_type" == "1" ] && [ "$mic_type" == "1" ]; then
		echo 0 > /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][USER]disable fan  enable_mic" > /dev/kmsg
	else
		if [ "$fan_type" == "0" ]; then
			echo 0 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][USER]disable fan" > /dev/kmsg
		elif [ "$fan_type" == "1" ]; then
			echo 42 >  /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][USER]fan_type 1 : low 42" > /dev/kmsg
		elif [ "$fan_type" == "2" ]; then		
			echo 50 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][USER]fan_type 2 : medium 46 " > /dev/kmsg
		elif [ "$fan_type" == "3" ]; then
			echo 55 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][USER]fan_type 3 : high 50 " > /dev/kmsg
		elif [ "$fan_type" == "4" ]; then
			echo 70 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][USER]fan_type 4 : turbo 55" > /dev/kmsg
		elif [ "$fan_type" == "auto" ]; then
			setprop persist.asus.tempfan 1
			echo "[STATION_FAN][AUTO]thermal fan will be set auto" > /dev/kmsg
		elif [ "$fan_type" == "csc_test" ]; then
			echo 70 > /sys/class/ec_i2c/dongle/device/duty
			sleep 2
			rpm=`cat /sys/class/ec_i2c/dongle/device/rpm`
			setprop vendor.fan.rpm "$rpm"
		fi
	fi
	#CHECK IF sys.asus.fan.mic changed during running this process+++
	mic_type_new=`getprop sys.asus.fan.mic`
	if [ "$mic_type_new" == "$mic_type" ];then
		echo "[STATION_FAN][USER] mic_type_new=$mic_type_new mic_type=$mic_type " > /dev/kmsg
		exit 0
	else
		echo "[STATION_FAN][USER]user fan set . 1st check mic_type=$mic_type; mic_type_new=$mic_type_new " > /dev/kmsg
		if [ "$micfansettings_type" == "1" ] && [ "$mic_type_new" == "1" ]; then
			enable_mic
			exit 0
		else
			disable_mic
			exit 0
		fi
	fi
	#CHECK IF sys.asus.fan.mic changed during running this process---
	#CHECK IF sys.asus.fan.mic changed during running this process for double check+++
	mic_type_new=`getprop sys.asus.fan.mic`
	if [ "$mic_type_new" == "$mic_type" ];then
		echo "[STATION_FAN][USER]mic_type_new=$mic_type_new mic_type=$mic_type " > /dev/kmsg
		exit 0
	else
		echo "[STATION_FAN][USER]user fan set . 2nd check mic_type=$mic_type; mic_type_new=$mic_type_new " > /dev/kmsg
		if [ "$micfansettings_type" == "1" ] && [ "$mic_type_new" == "1" ]; then
			enable_mic
			exit 0
		else
			disable_mic
			exit 0
		fi
	fi
	#CHECK IF sys.asus.fan.mic changed during running this process for double check---
fi

