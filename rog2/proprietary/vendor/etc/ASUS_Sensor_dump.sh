#!/vendor/bin/sh

export PATH=/system/bin
THERMAL_DUMPSYS=`getprop sys.thermal.dumpsys`
if [ "$THERMAL_DUMPSYS" == "1" ]; then
    setprop vendor.thermal.dumpsys_done 0
	LINE=`cat /asdf/sensor/dumpsys_sensorservice.txt|wc -l`
	#echo "$LINE" >> /asdf/sensor/dumpsys_sensorservice.txt
	if [ "$LINE" -ge "2000" ]; then
	    #echo "=============BIGGER===========" >> /asdf/sensor/dumpsys_sensorservice.txt
	    sed -i '1,100 d' /asdf/sensor/dumpsys_sensorservice.txt
	fi
	#echo "`cat /asdf/sensor/dumpsys_sensorservice.txt|wc -l`" >> /asdf/sensor/dumpsys_sensorservice.txt
	echo "[`date +%Y/%m/%d` `date +%T`] dumpsys sensorservice" >> /asdf/sensor/dumpsys_sensorservice.txt
    dumpsys sensorservice | grep -A50 'active connection' >> /asdf/sensor/dumpsys_sensorservice.txt
    #/vendor/bin/sns_dump_pm
    #setprop vendor.thermal.dumpsys_done 1
    #setprop sys.thermal.dumpsys 0
    #setprop sys.thermal.dumpsys_sns 1
fi

#START_LOG=`getprop persist.asus.startlog`
#if [ "$START_LOG" == "1" ]; then
#    setprop vendor.thermal.startlog 1
#fi
