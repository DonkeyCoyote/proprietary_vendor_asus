#!/system/vendor/bin/sh

#echo $0 > /proc/asusevtlog

android_boot=`getprop sys.boot_completed`
platform=`getprop ro.build.product`
imei1=`getprop persist.vendor.radio.device.imei`
imei2=`getprop persist.vendor.radio.device.imei2`
#repartition=`getprop ro.boot.rawdump_en`
repartition=`grep -c androidboot.rawdump_en=1 /proc/cmdline`
stage=`getprop ro.boot.id.stage`
memsize=`getprop ro.vendor.memsize`

# ZS661KS Q
echo "ro.build.product = $platform"
if [ "$platform" != "ZS661KS" ]; then
	echo "It is not ZS661KS !!"
	exit
fi

# check boot complete
timeout=0
while [ "$android_boot" -ne "1" ]; do
	timeout=$(($timeout+1))
	if [ $timeout == 300 ]; then
		echo "[Debug] check boot complete timeout exit ($timeout)!!" > /proc/asusevtlog
		exit
	fi
	echo "boot not ready !!"
	sleep 1
	android_boot=`getprop sys.boot_completed`
done
echo "boot ready ($android_boot)!!"

# Check MP
if [ "$stage" == "7" ]; then
	# Check IMEI
	imei_result1=`grep -c "$imei1" /vendor/etc/IMEI_whitelist.txt`
	echo "[Debug] check imei1 : $imei_result1"
	imei_result2=`grep -c "$imei2" /vendor/etc/IMEI_whitelist.txt`
	echo "[Debug] check imei2 : $imei_result2"
	if [ "$imei_result1" == "1" ] || [ "$imei_result2" == "1" ]; then
		echo "[Debug] whitelist imei found !!" > /proc/asusevtlog
	else
		# RSASD 
		# wait 1 sec to get /sdcard/dat.bin
		sync
		sleep 1
		sync
		myShellVar=`(rsasd)`
		sleep 1
		sync
		#myShellVar=`$(rsasd)`
		echo "[Debug] myShellVar = ($myShellVar)!!"
		echo "[Debug] whitelist imei not found!!"
		if [ "$myShellVar" == "13168" ]; then
			echo "[Debug] check rsasd : pass" > /proc/asusevtlog
		else
			echo "[Debug] check rsasd : fail" > /proc/asusevtlog
			exit
		fi
	fi
fi

if [ "$repartition" -ne "1" ]; then
	#dd
	if [ "$memsize" == "16GB" ]; then
		echo "[Debug] memsize = $memsize dd gpt_both0_16GB.bin"
		dd if=/vendor/etc/gpt_both0_16GB.bin of=/dev/block/sda9
	else
		echo "[Debug] memsize = $memsize dd gpt_both0.bin"
		dd if=/vendor/etc/gpt_both0.bin of=/dev/block/sda9
	fi
	sync
	echo "[Debug] prepare repartition" > /proc/asusevtlog
	#reboot oem-78
else
	echo "[Debug] exit"
	exit
fi
