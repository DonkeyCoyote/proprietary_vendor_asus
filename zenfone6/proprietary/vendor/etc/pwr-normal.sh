#!/vendor/bin/sh -x
#This is normal mode

#disable DPST function
#echo 0 > proc/cabc_mode_switch

setprop persist.asus.power.mode normal

cabc=0
status=1
echo $status > /proc/driver/touch_charger_mode
echo $cabc > /proc/driver/cabc
