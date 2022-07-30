#!/vendor/bin/sh
#calibration
setprop vendor.asus.rstgy2k.result "2"
result=$(/vendor/bin/Asus2ndGyroSensor_calS)
#check return value
if [ "$result" != "1" ]; then
	exit
fi
#check calibration data - 0
result=$(/vendor/bin/Asus2ndGyroSensor_getCalData 0)
if [ ${#result} -eq 0 ] || [ "${result:0:1}" == "F" ];
then
	setprop vendor.asus.rstgy2k.result "0 - getCalData 0 FAIL"
	exit
fi
#check calibration data - 1
result=$(/vendor/bin/Asus2ndGyroSensor_getCalData 1)
if [ ${#result} -eq 0 ] || [ "${result:0:1}" == "F" ];
then
	setprop vendor.asus.rstgy2k.result "0 - getCalData 1 FAIL"
	exit
fi
#check calibration data - 2
result=$(/vendor/bin/Asus2ndGyroSensor_getCalData 2)
if [ ${#result} -eq 0 ] || [ "${result:0:1}" == "F" ];
then
	setprop vendor.asus.rstgy2k.result "0 - getCalData 2 FAIL"
	exit
fi
setprop vendor.asus.rstgy2k.result 1
