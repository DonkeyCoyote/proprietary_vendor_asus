#!/vendor/bin/sh

PROXM_SPEC_FILE="/data/data/proximity_spec"
PROXM_2ND_SPEC_FILE="/data/data/proximity_2nd_spec" 
LIGHT_SPEC_FILE="/data/data/lightsensor_spec"
LIGHT_2ND_SPEC_FILE="/data/data/lightsensor_2nd_spec"

PROXM_INF_FILE="/vendor/factory/psensor_inf.nv"
PROXM_HI_FILE="/vendor/factory/psensor_hi.nv"
PROXM_LOW_FILE="/vendor/factory/psensor_low.nv"
PROXM_1CM_FILE="/vendor/factory/psensor_1cm.nv"
PROXM_2CM_FILE="/vendor/factory/psensor_2cm.nv"
PROXM_3CM_FILE="/vendor/factory/psensor_3cm.nv"
PROXM_4CM_FILE="/vendor/factory/psensor_4cm.nv"
PROXM_5CM_FILE="/vendor/factory/psensor_5cm.nv"
PROXM_2ND_INF_FILE="/vendor/factory/psensor_2nd_inf.nv"
PROXM_2ND_HI_FILE="/vendor/factory/psensor_2nd_hi.nv"
PROXM_2ND_LOW_FILE="/vendor/factory/psensor_2nd_low.nv"
PROXM_2ND_1CM_FILE="/vendor/factory/psensor_2nd_1cm.nv"
PROXM_2ND_2CM_FILE="/vendor/factory/psensor_2nd_2cm.nv"
PROXM_2ND_3CM_FILE="/vendor/factory/psensor_2nd_3cm.nv"
PROXM_2ND_4CM_FILE="/vendor/factory/psensor_2nd_4cm.nv"
PROXM_2ND_5CM_FILE="/vendor/factory/psensor_2nd_5cm.nv"
LIGHT_FILE="/vendor/factory/lsensor.nv"
LIGHT_400_FILE="/vendor/factory/lsensor_400ms.nv"
LIGHT_200_FILE="/vendor/factory/lsensor_200ms.nv"
LIGHT_100_FILE="/vendor/factory/lsensor_100ms.nv"
LIGHT_50_FILE="/vendor/factory/lsensor_50ms.nv"
LIGHT_2ND_FILE="/vendor/factory/lsensor_2nd.nv"
LIGHT_2ND_100_FILE="/vendor/factory/lsensor_2nd_100ms.nv"
LIGHT_2ND_50_FILE="/vendor/factory/lsensor_2nd_50ms.nv"
GSENSOR_X_FILE="/vendor/factory/gsensor_x.nv"
GSENSOR_Y_FILE="/vendor/factory/gsensor_y.nv"
GSENSOR_Z_FILE="/vendor/factory/gsensor_z.nv"
PLSENSOR_VER_FILE="/vendor/factory/pl_ver"
sensor_chmod()
{
	if [ -f $1 ];
	then
		echo "File $FILE exists"
		chmod 660 $1
		chown system:shell $1
	else
		echo "File $FILE does not exists"
		echo 0 > $1
		chmod 660 $1
		chown system:shell $1
	fi
}

sensor_ver_chmod(){
	if [ -f $1 ];
	then
		echo "File $FILE exists"
		chmod 660 $1
		chown system:shell $1
	else
		echo "File $FILE does not exists"
		echo "v1" > $1
		chmod 660 $1
		chown system:shell $1
	fi
}

sensor_chmod $PROXM_SPEC_FILE
sensor_chmod $PROXM_2ND_SPEC_FILE
sensor_chmod $LIGHT_SPEC_FILE
#sensor_chmod $LIGHT_2ND_SPEC_FILE

sensor_chmod $PROXM_INF_FILE
sensor_chmod $PROXM_HI_FILE
sensor_chmod $PROXM_LOW_FILE
sensor_chmod $PROXM_1CM_FILE
sensor_chmod $PROXM_2CM_FILE
sensor_chmod $PROXM_3CM_FILE
sensor_chmod $PROXM_4CM_FILE
sensor_chmod $PROXM_5CM_FILE
sensor_chmod $PROXM_2ND_INF_FILE
sensor_chmod $PROXM_2ND_HI_FILE
sensor_chmod $PROXM_2ND_LOW_FILE
sensor_chmod $PROXM_2ND_1CM_FILE
sensor_chmod $PROXM_2ND_2CM_FILE
sensor_chmod $PROXM_2ND_3CM_FILE
sensor_chmod $PROXM_2ND_4CM_FILE
sensor_chmod $PROXM_2ND_5CM_FILE
sensor_chmod $LIGHT_FILE
sensor_chmod $LIGHT_400_FILE
sensor_chmod $LIGHT_200_FILE
sensor_chmod $LIGHT_100_FILE
sensor_chmod $LIGHT_50_FILE
#sensor_chmod $LIGHT_2ND_FILE
#sensor_chmod $LIGHT_2ND_100_FILE
#sensor_chmod $LIGHT_2ND_50_FILE
sensor_ver_chmod $PLSENSOR_VER_FILE

sensor_chmod $GSENSOR_X_FILE
sensor_chmod $GSENSOR_Y_FILE
sensor_chmod $GSENSOR_Z_FILE

exit 0
