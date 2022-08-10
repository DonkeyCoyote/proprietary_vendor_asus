#!/vendor/bin/sh

type=`getprop vendor.asus.dongletype`
update_flag=`getprop vendor.dt.hub2_fwupdate`
fw_status2=`getprop vendor.asus.accy.fw_status2`
LOG_TAG="dt_hub2_fw_update"
hub2_version=`getprop vendor.dt.hub2_fwver`
lsusb_PATH="/data/vendor/gl_usb_list"
FW_PATH="/vendor/asusfw/DT_hub_fw/DT_6942_HUB2.bin"
FW_VER=`getprop vendor.asusfw.dt.hub2_fwver`

if [ "$update_flag" == "1" ]; then
	if [ "$type" == "3" ];then
		echo 1 > /sys/class/leds/DT_power/pd_switch
		echo 1 > /sys/class/leds/DT_power/pause
		echo "$LOG_TAG:[USB_ACCY] update fw $hub2_version to $FW_VER" > /dev/kmsg
		lsusb | grep 05e3:0610 > $lsusb_PATH
		/vendor/bin/DTHubFwUpdater isp -t single -n 1 -b $FW_PATH
		lsusb | grep 05e3:0610 > $lsusb_PATH
		hub2_version=`/vendor/bin/DTHubFwUpdater version |grep "\[1\]" | cut -d ":" -f 2`
		echo "$LOG_TAG:[USB_ACCY] DT hub2 version = $hub2_version" > /dev/kmsg
		setprop vendor.dt.hub2_fwver $hub2_version
		if [ "$hub2_version" == "$FW_VER" ]; then
			echo "$LOG_TAG:[USB_ACCY] update success" > /dev/kmsg
			setprop vendor.dt.hub2_fwupdate 0
			setprop vendor.dt.accy_statusupdate 1
		else
			echo "$LOG_TAG:[USB_ACCY] update fail" > /dev/kmsg
			setprop vendor.dt.hub2_fwupdate 2
		fi
		rm $lsusb_PATH
		echo 0 > /sys/class/leds/DT_power/pause
		echo 0 > /sys/class/leds/DT_power/pd_switch
	else
		echo "$LOG_TAG:[USB_ACCY] not connect DT" > /dev/kmsg
		setprop vendor.dt.hub2_fwupdate 2
	fi
fi
