#!/bin/sh
# Prepare files needed for flashing a Apalis/Colibri iMX6 module
#
# inspired by meta-fsl-arm/classes/image_types_fsl.bbclass

# exit on error
set -e



Usage()
{
	echo ""
	echo "Build for tarform "
	echo ""
}

cd ./src/rootfs/buildroot-2019.02.3
echo "**************configuring builldroot ***********************"
make toradex_apalis_imx6_tarform_defconfig

echo "**************Building builldroot ***********************"
make

cd ../../app/tarform
echo "**************Building App ***********************"
../../rootfs/buildroot-2019.02.2/output/host/bin/qmake

make
