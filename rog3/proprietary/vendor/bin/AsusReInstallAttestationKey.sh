#!/vendor/bin/sh

LOG_TAG="REWORK_COUNTRY"

COUNTRY=""
NEW_COUNTRY=""
IMEI1=""
HK_DEVICE=""

logi ()
{
	/vendor/bin/log -t $LOG_TAG -p i "$@"
}

get_SL ()
{
	SL=`getenforce`
	COUNT=1
	while [ "$SL" != "Permissive" ] && [ "$COUNT" -le 60 ]
	do
		logi "retry $COUNT"
		setprop vendor.sys.asus.setenforce 1
		sleep 5
		SL=`getenforce`
		COUNT=$(($COUNT+1))
		sleep 1
	done

	if [ "$SL" != "Permissive" ] ;then
		logi "fail, just exit"
		setprop vendor.sys.asus.setenforce 0
		exit
	fi
}

set_country ()
{
	COUNTRY=`cat mnt/vendor/persist/COUNTRY`
	#IMEI1=`getprop persist.vendor.radio.device.imei`
	IMEI1=`cat mnt/vendor/persist/IMEI`

	if [  -z "$IMEI1" ] ;then
		logi "CANNOT GET IMEI1, just exit!"
		exit
	fi

	HK_DEVICE=`cat vendor/bin/HK-202008.csv | grep $IMEI1`

	logi "COUNTRY = $COUNTRY"
	logi "IMEI1 = $IMEI1"
	logi "HK_DEVICE = $HK_DEVICE"

	if [ "$COUNTRY" != "HK" ] && [ ! -z "$HK_DEVICE" ] ;then

		setprop vendor.sys.asus.setenforce 1
		sleep 8

		get_SL

		logi "need to rewrite."
		# write HK to COUNTRY
		echo -n "HK" > mnt/vendor/persist/COUNTRY

		chmod 666 mnt/vendor/persist/COUNTRY
		chown shell:shell mnt/vendor/persist/COUNTRY

		NEW_COUNTRY=`cat mnt/vendor/persist/COUNTRY`

		setprop vendor.x-rr.vendor.config.versatility $NEW_COUNTRY
		#serial_client -c at+cnvm=3,8013,484B0000

        echo "at+cnvm=3,8013,484B0000\r" > /dev/mhi_0306_02.01.00_pipe_32
        #cat /dev/mhi_0306_02.01.00_pipe_32

		logi "NEW_COUNTRY = $NEW_COUNTRY, rewrite done."

		sleep 1
		setprop vendor.sys.asus.setenforce 0
	else
		logi "do nothing."
	fi

}

set_country
