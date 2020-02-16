## BUILDROOT package for building the Linux root tree

### Buildroot documentation used

Buildroot user manual:

	https://buildroot.org/downloads/manual/manual.html

[Bootlin] Buildroot practical lab training material:

	https://bootlin.com/doc/training/buildroot/buildroot-labs.pdf

[Bootlin] Buildroot Training slides:

	https://bootlin.com/doc/training/buildroot/buildroot-slides.pdf

### Buildroot Setup (by the time of writing the latest buildroot tag used)

	git clone git://git.buildroot.net/git/buildroot.git
	git branch buildroot-2020.02
	git checkout buildroot-2020.02

### Kernels used with Buildroot

Normal vanilla kernels:

	https://mirrors.edge.kernel.org/pub
	https://mirrors.edge.kernel.org/pub/linux/kernel

Civil Infrastructure Projects Real Time (CIP RT) kernels used from:

	https://git.kernel.org/pub
	https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
	https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-4.19.98-cip19-rt7.tar.gz

### Buildroot Build

Build Buildrool using an ARM cross compiler, Debian Buster and Fedora 31:

To make .config file, the following command is required:

	Debian:
	ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 beaglebone_defconfig

	Fedora:
	ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 beaglebone_defconfig

### Buildroot customization

To customize .config file, the following command is required:

	Debian:
	ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 menuconfig

	Fedora:
	ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 menuconfig

### Actual Buildroot compilation

	Debian:
	ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8

	Fedora:
	ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8

### The practical Buildroot configuration (from .config, but also other sources)

	# Buildroot 2020.02-git-01338-gc5ae77c97a Configuration

	# Target options
	BR2_ARCH_HAS_TOOLCHAIN_BUILDROOT=y
	BR2_ARCH="arm"
	BR2_ENDIAN="LITTLE"
	BR2_GCC_TARGET_ABI="aapcs-linux"
	BR2_GCC_TARGET_CPU="cortex-a8"
	BR2_GCC_TARGET_FPU="vfpv3-d16"
	BR2_GCC_TARGET_FLOAT_ABI="hard"
	BR2_GCC_TARGET_MODE="arm"
	BR2_BINFMT_SUPPORTS_SHARED=y
	BR2_READELF_ARCH_NAME="ARM"
	BR2_BINFMT_ELF=y
	BR2_ARM_CPU_HAS_NEON=y
	BR2_ARM_CPU_HAS_FPU=y
	BR2_ARM_CPU_HAS_VFPV2=y
	BR2_ARM_CPU_HAS_VFPV3=y
	BR2_ARM_CPU_HAS_ARM=y
	BR2_ARM_CPU_HAS_THUMB2=y
	BR2_ARM_CPU_ARMV7A=y

	# Mirrors and Download locations (THESE pointers to be reviewed and fixed/swapped to more appropriate ones)
	BR2_PRIMARY_SITE=""
	BR2_BACKUP_SITE="http://sources.buildroot.net"
	BR2_KERNEL_MIRROR="https://cdn.kernel.org/pub"# Toolchain
	BR2_GNU_MIRROR="http://ftpmirror.gnu.org"

	# Toolchain
	BR2_TOOLCHAIN=y
	BR2_TOOLCHAIN_USES_GLIBC=y
	BR2_TOOLCHAIN_BUILDROOT=y

	# Kernel Header Options
	BR2_KERNEL_HEADERS_AS_KERNEL=y
	BR2_KERNEL_HEADERS_LATEST=y
	BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_5_4=y
	BR2_PACKAGE_LINUX_HEADERS=y

	# Glibc Options
	BR2_PACKAGE_GLIBC=y
	BR2_PACKAGE_GLIBC_UTILS=y

	# Binutils Options
	BR2_PACKAGE_HOST_BINUTILS_SUPPORTS_CFI=y
	BR2_BINUTILS_VERSION_2_32_X=y
	BR2_BINUTILS_VERSION="2.32"
	BR2_BINUTILS_EXTRA_CONFIG_OPTIONS=""

	# GCC Options (9.2,0 does not compile?! - Need to verify)
	BR2_GCC_VERSION_8_X=y
	BR2_GCC_VERSION="8.3.0"
	BR2_EXTRA_GCC_CONFIG_OPTIONS=""

	# System configuration (after all, it is SYSTEMD, NOT BusyBox!)
	BR2_ROOTFS_SKELETON_DEFAULT=y
	BR2_TARGET_GENERIC_HOSTNAME="buildroot"
	BR2_TARGET_GENERIC_ISSUE="Welcome to Buildroot"
	BR2_TARGET_GENERIC_PASSWD_SHA256=y
	BR2_TARGET_GENERIC_PASSWD_METHOD="sha-256"
	BR2_INIT_SYSTEMD=y

	SYSTEMD Configuration used:

	The third solution is systemd. systemd is the new generation init system for Linux. It does far
	more than traditional init programs: aggressive parallelization capabilities, uses socket and
	D-Bus activation for starting services, offers on-demand starting of daemons, keeps track of
	processes using Linux control groups, supports snapshotting and restoring of the system state,
	etc. systemd will be useful on relatively complex embedded systems, for example the ones
	requiring D-Bus and services communicating between each other. It is worth noting that systemd
	brings a fairly big number of large dependencies: dbus, udev and more. For more details about
	systemd, see http://www.freedesktop.org/wiki/Software/systemd.

	# Kernel
	BR2_LINUX_KERNEL=y
	BR2_LINUX_KERNEL_LATEST_VERSION=y
	BR2_LINUX_KERNEL_VERSION="5.4.18"
	BR2_LINUX_KERNEL_PATCH=""
	BR2_LINUX_KERNEL_USE_DEFCONFIG=y
	BR2_LINUX_KERNEL_DEFCONFIG="omap2plus"
	BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES=""
	BR2_LINUX_KERNEL_CUSTOM_LOGO_PATH=""
	BR2_LINUX_KERNEL_ZIMAGE=y
	BR2_LINUX_KERNEL_GZIP=y
	BR2_LINUX_KERNEL_DTS_SUPPORT=y
	BR2_LINUX_KERNEL_INTREE_DTS_NAME="am335x-evm am335x-bone am335x-boneblack am335x-bonegreen am335x-boneblue"
	BR2_LINUX_KERNEL_CUSTOM_DTS_PATH=""
	BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y

### The Buildroot output directory (where the results are stored)

	.../buildroot/output/images
	[.../buildroot/output/images]$ ls -al
	total 158972
	drwxr-xr-x. 2 vuser vboxusers     4096 Feb 11 10:57 .
	drwxr-xr-x. 6 vuser vboxusers     4096 Feb 11 10:57 ..
	-rw-r--r--. 1 vuser vboxusers    58300 Feb 11 10:57 am335x-boneblack.dtb
	-rw-r--r--. 1 vuser vboxusers    57898 Feb 11 10:57 am335x-boneblue.dtb
	-rw-r--r--. 1 vuser vboxusers    56484 Feb 11 10:57 am335x-bone.dtb
	-rw-r--r--. 1 vuser vboxusers    56740 Feb 11 10:57 am335x-bonegreen.dtb
	-rw-r--r--. 1 vuser vboxusers    63027 Feb 11 10:57 am335x-evm.dtb
	-rw-r--r--. 1 vuser vboxusers    61679 Feb 11 10:57 am335x-evmsk.dtb
	-rw-r--r--. 1 vuser vboxusers 16777216 Feb 11 10:57 boot.vfat
	-rw-r--r--. 1 vuser vboxusers   107356 Feb 11 10:39 MLO
	-rw-r--r--. 1 vuser vboxusers 62914560 Feb 11 10:57 rootfs.ext2
	lrwxrwxrwx. 1 vuser vboxusers       11 Feb 11 10:57 rootfs.ext4 -> rootfs.ext2
	-rw-r--r--. 1 vuser vboxusers 46551040 Feb 11 10:57 rootfs.tar
	-rw-r--r--. 1 vuser vboxusers 79692288 Feb 11 10:57 sdcard.img
	-rw-r--r--. 1 vuser vboxusers   761880 Feb 11 10:39 u-boot.img
	-rw-r--r--. 1 vuser vboxusers      434 Feb 11 10:57 uEnv.txt
	-rw-r--r--. 1 vuser vboxusers  5712936 Feb 11 10:57 zImage
	[.../buildroot/output/images]$
