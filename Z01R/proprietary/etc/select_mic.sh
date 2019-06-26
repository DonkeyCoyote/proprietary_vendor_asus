#!/system/bin/sh
value=$1
setprop persist.asus.mic.selected ${value}
current=`getprop persist.asus.mic.selected`
if [[ ${current} -eq ${value} ]]; then
	echo 1
else
	echo 0
fi
