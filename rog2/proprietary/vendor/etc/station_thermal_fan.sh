#!/vendor/bin/sh

dongle_type=`getprop vendor.asus.dongletype`
fan_type=`getprop persist.sys.asus.userfan`
thermal_type=`getprop persist.asus.thermalfan`
micfansettings_type=`getprop persist.asus.micfansettings`
mic_type=`getprop sys.asus.fan.mic`


function enable_mic(){
	echo 0 > /sys/class/ec_i2c/dongle/device/duty
	echo "[STATION_FAN][AUTO]enable_mic after sys.asus.fan.mic changed" > /dev/kmsg
}

function disable_mic(){
	fan_type=`getprop persist.sys.asus.userfan`
	if [ "$fan_type" == "auto" ]; then
		echo "[station_thermal_fan.sh][disable_mic] thermal fan" > /dev/kmsg
		if [ "$thermal_type" == "0" ]; then
			echo 42 >  /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][AUTO]thermal_type 0: default 1 (low) 42 " > /dev/kmsg
		elif [ "$thermal_type" == "1" ]; then
			echo 42 >  /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][AUTO]fan_type 1 : low 42" > /dev/kmsg
		elif [ "$thermal_type" == "2" ]; then
			echo 50 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][AUTO]fan_type 2 : medium 46" > /dev/kmsg 
		elif [ "$thermal_type" == "3" ]; then
			echo 55 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][AUTO]fan_type 3 : high 50" > /dev/kmsg
		elif [ "$thermal_type" == "4" ]; then
			echo 70 > /sys/class/ec_i2c/dongle/device/duty
			echo "[STATION_FAN][AUTO]thermal_type 4 :55" > /dev/kmsg
		fi
	else
		echo "[STATION_FAN][AUTO]thermal fan will not  be set auto" > /dev/kmsg 
	fi
}


if [ "$dongle_type" == "2" ]; then
	if [ "$micfansettings_type" == "1" ] && [ "$mic_type" == "1" ]; then
		echo 0 > /sys/class/ec_i2c/dongle/device/duty
		echo "[STATION_FAN][AUTO]disable fan enable_mic " > /dev/kmsg
	else
		if [ "$fan_type" == "auto" ]; then
			echo "[station_thermal_fan.sh] thermal fan, fan_type is auto" > /dev/kmsg
			if [ "$thermal_type" == "0" ]; then
				echo 42 >  /sys/class/ec_i2c/dongle/device/duty
				echo "[STATION_FAN][AUTO]thermal_type 0: default 1 (low) 42 " > /dev/kmsg
			elif [ "$thermal_type" == "1" ]; then
				echo 42 >  /sys/class/ec_i2c/dongle/device/duty
				echo "[STATION_FAN][AUTO]fan_type 1 : low 42" > /dev/kmsg
			elif [ "$thermal_type" == "2" ]; then
				echo 50 > /sys/class/ec_i2c/dongle/device/duty
				echo "[STATION_FAN][AUTO]fan_type 2 : medium 46" > /dev/kmsg 
			elif [ "$thermal_type" == "3" ]; then
				echo 55 > /sys/class/ec_i2c/dongle/device/duty
				echo "[STATION_FAN][AUTO]fan_type 3 : high 50" > /dev/kmsg
			elif [ "$thermal_type" == "4" ]; then
				echo 70 > /sys/class/ec_i2c/dongle/device/duty
				echo "[STATION_FAN][AUTO]thermal_type 4 :55" > /dev/kmsg
			fi
		else
				echo "[STATION_FAN][AUTO]thermal fan will not  be set auto" > /dev/kmsg 
		fi
	fi

	#check sys.asus.fan.mic++++
	mic_type_new=`getprop sys.asus.fan.mic`
	if [ "$mic_type_new" == "$mic_type" ];then
		echo "[STATION_FAN][AUTO] mic_type_new=$mic_type_new mic_type=$mic_type" > /dev/kmsg
		exit 0
	else
		echo "[STATION_FAN][AUTO]thermal fan set . 1st check mic_type=$mic_type; mic_type_new=$mic_type_new " > /dev/kmsg
		if [ "$micfansettings_type" == "1" ] && [ "$mic_type_new" == "1" ]; then
			enable_mic
			exit 0
		else
			disable_mic
			exit 0
		fi
	fi

	mic_type_new=`getprop sys.asus.fan.mic`
	if [ "$mic_type_new" == "$mic_type" ];then
		exit 0
	else
		echo "[STATION_FAN][AUTO]thermal fan set . 2nd check mic_type=$mic_type; mic_type_new=$mic_type_new " > /dev/kmsg
		if [ "$micfansettings_type" == "1" ] && [ "$mic_type_new" == "1" ]; then
			enable_mic
			exit 0
		else
			disable_mic
			exit 0
		fi
	fi
	#check sys.asus.fan.mic---
fi

