MemTotalStr=`cat /proc/meminfo | grep MemTotal`
MemTotal=${MemTotalStr:16:8}
let RamSizeGB="( $MemTotal / 1048576 ) + 1"

zram_enable=`getprop persist.vendor.zram.enable`
expandmem_enable=`getprop persist.vendor.asus.expandmem.enable`

function set_expandmem() {
	zRamSize=`cat /sys/block/zram0/disksize`
	zRamSizeMB=`expr $zRamSize / 1048576`
	zRamCriticalSize=`expr $zRamSizeMB \* 90 / 100`
	zRamFreeLowSize=`expr $zRamSizeMB \* 10 / 100`
	echo "$zRamCriticalSize" > /dev/memcg/memory.zram_critical_threshold
	echo "900 800 1000 $zRamFreeLowSize" > /dev/memcg/memory.avail_buffers
	echo "0 0 0" > /dev/memcg/system/memory.zswapd_single_memcg_param
	echo "0 0 0" > /dev/memcg/apps/memory.zswapd_single_memcg_param
	echo "60 20 50" > /dev/memcg/memory.zswapd_single_memcg_param

	zRamLimit=`expr $zRamSize - 104857600`
	echo "$zRamLimit" > /sys/block/zram0/mem_limit
	echo 1 > /sys/devices/platform/soc/soc:expandmem/eswap_enable
}

if test "$zram_enable" != "0"; then
    if [ $RamSizeGB -le 12 ]; then
        if test "$expandmem_enable" = ""; then
            if [ $RamSizeGB -le 6 ]; then
                set_expandmem
            fi
        elif test "$expandmem_enable" = "1"; then
            set_expandmem
        elif test "$expandmem_enable" = "0"; then
            echo 0 > /sys/devices/platform/soc/soc:expandmem/eswap_enable
        fi
    fi
fi
