# am335x beaglebone-black-bsp
This repository is related to Texas Instruments Open Source Beaglebone Black referent development platform.

## am335x Beaglebone Black evaluation board setup

BeagleBone Black System Reference Manual

https://cdn-shop.adafruit.com/datasheets/BBB_SRM.pdf

element14 BeagleBone Black INDUSTRIALSystem Reference Manual 

http://download.kamami.pl/p562276-BBBI_SRM_Rev%201.0%20VL.pdf

## Get u-boot

The latest u-boot version might not work out of the box.

	git clone http://git.denx.de/u-boot.git u-boot-bbb OR
	git clone git://git.denx.de/u-boot.git u-boot-bbb
	cd u-boot-bbb

The cloned version will match HEAD set to master branch (the following command is optional):

	git checkout -b <branch-name> # Take the current HEAD (the commit checked
	# out) and create a new branch called <branch-name>

## Installing arm cross compiler on the host (the host used is Fedora 31 distro)

To install on Fedora 31 gcc-arm-linux-gnu.x86_64 (which is not native x86_64 compiler), the following command is used:

	sudo dnf install gcc-arm-linux-gnu.x86_64

To install on Debian Buster, the following command is used:

	sudo apt-get install gcc-arm-linux-gnueabihf

## u-boot Build

Build u-boot using an ARM cross compiler, e.g. Fedora 31 gcc-arm-linux-gnu.x86_64:

To make .config file, the following command is required:

	Fedora:
	ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 am335x-evm_defconfig

	Debian:
	ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 am335x-evm_defconfig

## Actual u-boot compilation:

    Fedora:
    ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8

    Debian:
    ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8
    
## Actual u-boot compilation for the expert developers (part of porting effort) with no valid .dts tree present

    Fedora:
    ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 EXT_DTB=<path/to/your/custom/built/dtb>

    Debian:
    ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 EXT_DTB=<path/to/your/custom/built/dtb>

## Place SPL and u-boot.img OR u-boot.imx on SD card

For the Sabre board case, u-boot.imx will not be generated as this board supports SPL. Two files are generated: SPL and u-boot.img.

In order to flash the SD card!

SPL should reside at offset 1024KB (1MB) of the SD card. To place it there (assuming sdX is sdb):

    $ sudo dd if=SPL of=/dev/sdb bs=1k seek=1; sync
    (Note - the SD card node may vary, so adjust this as needed).

    Flash the u-boot.img image into the SD card:
    $ sudo dd if=u-boot.img of=/dev/sdb bs=1k seek=69; sync

For the U-boot.imx case, it should reside at offset 1024KB (1MB) of the SD card. To place it there:

    $ sudo dd if=u-boot.imx of=/dev/sdb bs=1k seek=1; sync

The SD card device is typically something as /dev/sd<X> or /dev/mmcblk<X>. Note that there is a need for write permissions on the SD card for the command to succeed, so there is a need to su - as root, or use sudo, or do a chmod a+w as root on the SD card device node to grant permissions to users.

## The actual log from the u-boot Sabre Automotive booting:

    U-Boot 2019.10-rc1-00132-gfef408679b (Aug 09 2019 - 17:09:06 +0200)

    CPU:   Freescale i.MX6Q rev1.2 996 MHz (running at 792 MHz)
    CPU:   Automotive temperature grade (-40C to 125C) at 20C
    Reset cause: POR
    Model: Freescale i.MX6 Quad SABRE Automotive Board
    Board: MX6Q-Sabreauto revD
    I2C:   ready
    DRAM:  2 GiB
    PMIC:  PFUZE100 ID=0x10
    wait_for_sr_state: Arbitration lost sr=33 cr=98 state=202
    wait_for_sr_state: failed sr=23 cr=88 state=2000
    i2c_imx_stop:trigger stop failed
    i2c_init_transfer: failed for chip 0x8 retry=0
    wait_for_sr_state: failed sr=21 cr=88 state=2000
    wait_for_sr_state: failed sr=21 cr=88 state=2000
    i2c_imx_stop:trigger stop failed
    i2c_init_transfer: failed for chip 0x8 retry=1
    wait_for_sr_state: Arbitration lost sr=33 cr=98 state=202
    wait_for_sr_state: failed sr=23 cr=88 state=2000
    i2c_imx_stop:trigger stop failed
    i2c_init_transfer: failed for chip 0x8 retry=0
    wait_for_sr_state: failed sr=21 cr=88 state=2000
    wait_for_sr_state: failed sr=21 cr=88 state=2000
    i2c_imx_stop:trigger stop failed
    i2c_init_transfer: failed for chip 0x8 retry=1
    NAND:  0 MiB
    MMC:   FSL_SDHC: 0
    Loading Environment from MMC... *** Warning - bad CRC, using default environment

    In:    serial
    Out:   serial
    Err:   serial
    Net:   FEC [PRIME]
    Hit any key to stop autoboot:  0 
    =>

## Partitioning SD card

Here, two parttion are create: /dev/sdX1 for kernel, and /dev/sdX2 for rootfs.

Given example where /dev/sdX is /dev/sdb :

    echo "Create primary partition 1 for kernel"
    echo -e "n\np\n1\n\n+256M\nw\n"  | fdisk /dev/sdb

    echo "Create primary partition 2 for rootfs"
    echo -e "n\np\n2\n\n+8192M\nw\n"  | fdisk /dev/sdb

    echo "Formatting primary partition sdb1 for kernel"
    mkfs.vfat -F 32 /dev/sdb1

    echo "Formatting primary partition sdb2 for rootfs"
    mkfs.ext4 -F /dev/sdb2

## Making kernel using kernel.org vanilla (the latest stable upon writing this document) kernel 5.2.8

The kernel 5.2.8 source code is located @ the following location:

https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/

The file to be downloaded is the following: linux-5.2.8.tar.xz

The command to unpack the designated kernel is:

    tar -xvf inux-5.2.8.tar.xz
    cd linux-5.2.8/

To build the kernel, the following should be done:

Make proper .config:

    Fedora:
    ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 imx_v6_v7_defconfig

    Debian:
    ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 imx_v6_v7_defconfig

Compile the kernel itself:

    Fedora:
    ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8

    Debian:
    ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8

The kernel itself to be used is in the directory: .../linux-5.2.8/arch/arm/boot/ and it is called zImage:

    .../linux-5.2.8/arch/arm/boot/zImage

The .dtb file to be used is in the directory: .../linux-5.2.8/arch/arm/boot/dts/ and it is called imx6q-sabreauto.dtb

    .../linux-5.2.8/arch/arm/boot/dts/imx6q-sabreauto.dtb

The location on SD card both components should be placed is /dev/sdX1 mounted to some directory (example: /tmp/sdX1 (where the SD card itself is: /dev/sdX).

Assuming X=b, it looks like:

    mount /dev/sdb1 /tmp/sdb1

The following will happed after booting u-boot, and after booting kernel 5.2.8 from the SD card (initial boot @ [  0.000000]):

    Starting kernel ...

    [    0.000000] Booting Linux on physical CPU 0x0
    [    0.000000] Linux version 5.2.8 (vuser@fedora30-ssd) (gcc version 9.1.1 20190503 (Red Hat Cross 9.1.1-1) (GCC)) #1 SMP Wed
    Aug 14 09:54:08 CEST 2019
    [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
    [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
    [    0.000000] OF: fdt: Machine model: Freescale i.MX6 Quad SABRE Automotive Board
    [    0.000000] Memory policy: Data cache writealloc
    [    0.000000] cma: Reserved 64 MiB at 0x3c000000
    [    0.000000] percpu: Embedded 21 pages/cpu s54504 r8192 d23320 u86016
    [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
    [    0.000000] Kernel command line: console=ttymxc3,115200 root=PARTUUID=9468c8e5-02 rootwait rw
    [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
    [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
    [    0.000000] Memory: 1988512K/2097152K available (11264K kernel code, 935K rwdata, 4216K rodata, 1024K init, 6925K bss,
    43104K reserved, 65536K cma-reserved, 1310720K highmem)
    [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
    [    0.000000] Running RCU self tests
    [    0.000000] rcu: Hierarchical RCU implementation.
    [    0.000000] rcu: 	RCU event tracing is enabled.
    [    0.000000] rcu: 	RCU lockdep checking is enabled.
    [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
    [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
    [    0.000000] L2C-310 errata 752271 769419 enabled
    [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
    [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
    [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
    [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
    [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
    [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
    [    0.000000] random: get_random_bytes called from start_kernel+0x2ac/0x4ac with crng_init=0
    [    0.000000] Switching to timer-based delay loop, resolution 333ns

## Making rootfs (using latest up to date YOCTO thud distribution):

http://variwiki.com/index.php?title=Yocto_Build_Release&release=RELEASE_MORTY_V1

## Specific annexes/addendums to the YOCTO documentation above:

The tags are also listed in https://github.com/varigit/variscite-bsp-platform/tags

To specify a latest release/tag (up to date), the following should be issued:

    repo init -u https://github.com/varigit/variscite-bsp-platform.git -b refs/tags/thud-fslc-4.14.78-mx6ul-v1.1

To understand how to setup the environment, the following command should be issued:

    source setup-environment

After evaluating the documentation, the following is done to setup the proper environment:

    MACHINE=imx6qdlsabreauto DISTRO=fslc-x11 source setup-environment build
