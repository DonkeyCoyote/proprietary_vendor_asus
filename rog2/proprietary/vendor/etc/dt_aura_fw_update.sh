#!/vendor/bin/sh

type=`getprop vendor.asus.dongletype`

echo "[aura_dt] Enable VDD" > /dev/kmsg
echo 1 > /sys/class/leds/aura_dock/VDD
sleep 0.5

FW_PATH="/vendor/asusfw/aura_sync/ENE-8K41-aura-dt.bin"
fw_ver=`cat /sys/class/leds/aura_dock/fw_ver`
aura_fw=`getprop vendor.asusfw.dt.aura_fwver`

echo "[aura_dt] aura_fw : ${aura_fw}" > /dev/kmsg
echo "[aura_dt] fw_ver : ${fw_ver}" > /dev/kmsg

if [ "$type" == "3" ]; then
    echo 1 > /sys/class/leds/DT_power/pause
fi

if [ "${fw_ver}" != "${aura_fw}" ]; then
    echo "[aura_dt] Strat ENE 8K41 FW update" > /dev/kmsg
    echo $FW_PATH > /sys/class/leds/aura_dock/fw_update
else
    echo "[aura_dt] No need update" > /dev/kmsg
fi

fw_ver=`cat /sys/class/leds/aura_dock/fw_ver`
if [ "${fw_ver}" != "${aura_fw}" ]; then
	echo "[aura_dt] ENE 8K41 FW update fail" > /dev/kmsg
	echo 0 > /sys/class/leds/DT_power/pause
	setprop vendor.dt.aura_fwupdate 2
else
	echo 0 > /sys/class/leds/DT_power/pause
	setprop vendor.dt.aura_fwver $fw_ver
	setprop vendor.dt.aura_fwupdate 0

fi

#start DongleFWCheck
