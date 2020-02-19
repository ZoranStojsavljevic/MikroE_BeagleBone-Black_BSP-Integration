#!/bin/bash
# Copyright (C) 2020, Systems Software Research, Ltd., Zoran Stojsavljevic
# SPDX-License-Identifier: MIT License
# This program is free software: you can redistribute it and/or modify it under the terms of the MIT Public License.

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the MIT Public License for more details.

checkout_release () {
	CURRENT_DIR=`pwd`
	echo $CURRENT_DIR

	## meta-bbb
	git clone https://github.com/jumpnow/meta-bbb.git
	cd meta-bbb
	git checkout $ReleaseName
	cd ..

	## poky
	git clone https://git.yoctoproject.org/git/poky.git
	cd poky
	git checkout $ReleaseName
	cd ..

	## meta-openembedded
	git clone https://github.com/openembedded/meta-openembedded.git
	cd meta-openembedded
	git checkout $ReleaseName
	cd ..

	## meta-qt5
	git clone http://code.qt.io/yocto/meta-qt5.git
	cd meta-qt5
	git checkout upstream/$ReleaseName
	cd ..

	if [ "$ReleaseName" == zeus ]; then
		## generic meta-jumpnow YOCTO layer, serving as common
		## layer to seven different boards
		git clone https://github.com/jumpnow/meta-jumpnow.git
		cd meta-jumpnow
		git checkout $ReleaseName
		cd ..
	fi
}

set_build_env() {
	unset CURRENT_DIR
	CURRENT_DIR=`pwd`

	source oe-init-build-env build/ > /dev/null 2>&1
	bitbake-layers add-layer ../../meta-jumpnow/
	bitbake-layers add-layer ../../meta-bbb/
	bitbake-layers add-layer ../../meta-openembedded/meta-oe/
	bitbake-layers add-layer ../../meta-openembedded/meta-python/
	bitbake-layers add-layer ../../meta-openembedded/meta-networking/
	bitbake-layers add-layer ../../meta-qt5
	bitbake-layers show-layers
	cd ../..
	mv poky/build/ .
}

if [ $# -ne 1 ] ; then
	echo "Usage: $0 <YOCTO Release Name (starting from sumo release)>"
	exit 1
fi

ReleaseName=$1

names="zeus"
for name in $names
do
	if [ "$ReleaseName" == $name ]; then
		echo "Supported YOCTO Release Name entered $name!"
		rm -rf build/
		checkout_release
		cd poky/
		set_build_env
		cp bbb-releases/bbb-$name/local.conf build/conf/local.conf
		echo "The system is ready for making the YOCTO images!"
		echo `pwd`
		exit 0
	fi
done

echo "Non supported YOCTO Release Name entered $ReleaseName!"
exit 1
