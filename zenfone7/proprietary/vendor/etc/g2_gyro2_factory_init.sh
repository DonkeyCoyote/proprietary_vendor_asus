#!/vendor/bin/sh
sensor_chmod()
{
	if [ ! -f $1 ]; then
		touch $1
	fi
	chmod 660 $1
	chown system:shell $1
}

sensor_chmod /vendor/factory/gsensor2_x.nv
sensor_chmod /vendor/factory/gsensor2_y.nv
sensor_chmod /vendor/factory/gsensor2_z.nv
sensor_chmod /vendor/factory/gyrosensor2_x.nv
sensor_chmod /vendor/factory/gyrosensor2_y.nv
sensor_chmod /vendor/factory/gyrosensor2_z.nv
