LOG_TAG="SHIPPING_REWK"

logi ()
{
	/vendor/bin/log -t $LOG_TAG -p i "$@"
}

auth=`getprop vendor.factory.adbon`
NEW_COUNTRY=`getprop vendor.shipping.rework`
NEW_CID=`getprop vendor.shipping.rework.cid`

if [ "$auth" == "1" ];then

	if [ ! -z "$NEW_COUNTRY" ] && [ "$NEW_COUNTRY" != "0" ];then


		setprop vendor.sys.asus.setenforce 1

		sleep 5

		# reset trigger prop
		setprop vendor.shipping.rework 0

		# write NEW_COUNTRY
		echo -n "$NEW_COUNTRY" > mnt/vendor/persist/COUNTRY

		chmod 666 mnt/vendor/persist/COUNTRY
		chown shell:shell mnt/vendor/persist/COUNTRY

		# start SP/SSN/Devinfo
		setprop vendor.debug.update.deviceinfo 1
		sleep 2
		result=`getprop vendor.debug.update.deviceinfo.result`
		if [ "$result" == "1" ]; then
			logi "1; success"
		else
			logi "0; failed"
		fi

		# update AttKey
		/vendor/bin/install_key_server zf7prov

	elif [ ! -z "$NEW_CID" ] && [ "$NEW_CID" != "0" ];then

		setprop vendor.sys.asus.setenforce 1
		sleep 5

		# reset trigger prop
		setprop vendor.shipping.rework.cid 0

		# write NEW_COUNTRY
		echo -n "$NEW_CID" > mnt/vendor/persist/CUSTOMER

		chmod 666 mnt/vendor/persist/CUSTOMER
		chown shell:shell mnt/vendor/persist/CUSTOMER

		# start SP/SSN/Devinfo
		setprop vendor.debug.update.deviceinfo 1
		sleep 2
		result=`getprop vendor.debug.update.deviceinfo.result`
		if [ "$result" == "1" ]; then
			logi "1; success"
		else
			logi "0; failed"
		fi
	else
		logi "do nothing"
	fi
else
	logi "AUTHORIZE FAILED!!"
fi

setprop vendor.sys.asus.setenforce 0
