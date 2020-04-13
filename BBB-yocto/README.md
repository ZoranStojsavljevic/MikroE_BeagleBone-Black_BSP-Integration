### yocto/ is written to support referent BBB SDcard generation
Attempt to create one generic Open Source BeagleBone Black armv7 A8 platform reference and testing repository.
The YOCTO BeagleBobe Black yocto/ used is described @ the following net pointer:

https://jumpnowtek.com/beaglebone/BeagleBone-Systems-with-Yocto.html

### The bash script, customized for the owner's projects purposes: yocto-setup.sh

	Step [1]: Look into the script and customize it (if required) for proprieary project;
	Step [2]: Make the script yocto-setup.sh executable (permissions 755), and execute it: ./yocto-setup.sh zeus ;
	Step [3]: Execute the following: source poky/oe-init-build-env build (setup the bitbake environment);
	Step [4]: Run bitbake -k core-image-minimal ## or whatever core-image-? required

	[WARNING] Only last official YOCTO Release scripts ARE actively maintained (zeus)

### The yocto output directory (where the building/bitbake -k results are stored)

	[user@fedora31-ssd build]$ cd tmp/deploy/images/beaglebone/
	[user@fedora31-ssd beaglebone]$ ls -al
	.../yocto/tmp/deploy/images/beaglebone/
	[.../yocto/tmp/deploy/images/beaglebone/]$ ls -al
	total 790904
	drwxr-xr-x. 2 user vboxusers      4096 Feb 21 01:53 .
	drwxr-xr-x. 3 user vboxusers      4096 Feb 20 23:38 ..
	-rw-r--r--. 2 user vboxusers     57620 Feb 21 01:02 am335x-boneblack--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        57 Feb 21 01:02 am335x-boneblack-beaglebone.dtb -> am335x-boneblack--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        57 Feb 21 01:02 am335x-boneblack.dtb -> am335x-boneblack--5.4.21-r0-beaglebone-20200220223809.dtb
	-rw-r--r--. 2 user vboxusers     58851 Feb 21 01:02 am335x-boneblack-wireless--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        66 Feb 21 01:02 am335x-boneblack-wireless-beaglebone.dtb -> am335x-boneblack-wireless--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        66 Feb 21 01:02 am335x-boneblack-wireless.dtb -> am335x-boneblack-wireless--5.4.21-r0-beaglebone-20200220223809.dtb
	-rw-r--r--. 2 user vboxusers     57898 Feb 21 01:02 am335x-boneblue--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        56 Feb 21 01:02 am335x-boneblue-beaglebone.dtb -> am335x-boneblue--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        56 Feb 21 01:02 am335x-boneblue.dtb -> am335x-boneblue--5.4.21-r0-beaglebone-20200220223809.dtb
	-rw-r--r--. 2 user vboxusers     56060 Feb 21 01:02 am335x-bonegreen--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        57 Feb 21 01:02 am335x-bonegreen-beaglebone.dtb -> am335x-bonegreen--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        57 Feb 21 01:02 am335x-bonegreen.dtb -> am335x-bonegreen--5.4.21-r0-beaglebone-20200220223809.dtb
	-rw-r--r--. 2 user vboxusers     57401 Feb 21 01:02 am335x-bonegreen-wireless--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        66 Feb 21 01:02 am335x-bonegreen-wireless-beaglebone.dtb -> am335x-bonegreen-wireless--5.4.21-r0-beaglebone-20200220223809.dtb
	lrwxrwxrwx. 2 user vboxusers        66 Feb 21 01:02 am335x-bonegreen-wireless.dtb -> am335x-bonegreen-wireless--5.4.21-r0-beaglebone-20200220223809.dtb
	-rw-r--r--. 2 user vboxusers  85293332 Feb 21 01:53 core-image-minimal-beaglebone-20200220223809.rootfs.cpio.xz
	-rw-r--r--. 2 user vboxusers 710710272 Feb 21 01:49 core-image-minimal-beaglebone-20200220223809.rootfs.ext4
	-rw-r--r--. 2 user vboxusers     27704 Feb 21 01:48 core-image-minimal-beaglebone-20200220223809.rootfs.manifest
	-rw-r--r--. 2 user vboxusers  85635372 Feb 21 01:53 core-image-minimal-beaglebone-20200220223809.rootfs.tar.xz
	-rw-r--r--. 2 user vboxusers    271880 Feb 21 01:48 core-image-minimal-beaglebone-20200220223809.testdata.json
	lrwxrwxrwx. 2 user vboxusers        59 Feb 21 01:53 core-image-minimal-beaglebone.cpio.xz -> core-image-minimal-beaglebone-20200220223809.rootfs.cpio.xz
	lrwxrwxrwx. 2 user vboxusers        56 Feb 21 01:49 core-image-minimal-beaglebone.ext4 -> core-image-minimal-beaglebone-20200220223809.rootfs.ext4
	lrwxrwxrwx. 2 user vboxusers        60 Feb 21 01:48 core-image-minimal-beaglebone.manifest -> core-image-minimal-beaglebone-20200220223809.rootfs.manifest
	lrwxrwxrwx. 2 user vboxusers        58 Feb 21 01:53 core-image-minimal-beaglebone.tar.xz -> core-image-minimal-beaglebone-20200220223809.rootfs.tar.xz
	lrwxrwxrwx. 2 user vboxusers        58 Feb 21 01:48 core-image-minimal-beaglebone.testdata.json -> core-image-minimal-beaglebone-20200220223809.testdata.json
	lrwxrwxrwx. 2 user vboxusers        25 Feb 19 20:59 MLO -> MLO-beaglebone-2019.07-r0
	lrwxrwxrwx. 2 user vboxusers        25 Feb 19 20:59 MLO-beaglebone -> MLO-beaglebone-2019.07-r0
	-rw-r--r--. 2 user vboxusers    110812 Feb 19 20:59 MLO-beaglebone-2019.07-r0
	-rw-r--r--. 2 user vboxusers  64076549 Feb 21 01:02 modules--5.4.21-r0-beaglebone-20200220223809.tgz
	lrwxrwxrwx. 2 user vboxusers        48 Feb 21 01:02 modules-beaglebone.tgz -> modules--5.4.21-r0-beaglebone-20200220223809.tgz
	-rw-r--r--. 2 user vboxusers    753712 Feb 19 20:59 u-boot-beaglebone-2019.07-r0.img
	lrwxrwxrwx. 2 user vboxusers        32 Feb 19 20:59 u-boot-beaglebone.img -> u-boot-beaglebone-2019.07-r0.img
	lrwxrwxrwx. 2 user vboxusers        32 Feb 19 20:59 u-boot.img -> u-boot-beaglebone-2019.07-r0.img
	lrwxrwxrwx. 2 user vboxusers        47 Feb 21 01:02 zImage -> zImage--5.4.21-r0-beaglebone-20200220223809.bin
	-rw-r--r--. 2 user vboxusers   4634376 Feb 21 01:02 zImage--5.4.21-r0-beaglebone-20200220223809.bin
	lrwxrwxrwx. 2 user vboxusers        47 Feb 21 01:02 zImage-beaglebone.bin -> zImage--5.4.21-r0-beaglebone-20200220223809.bin

### Referent YOCTO Poky BeagleBone distro is also supported:

git clone https://git.yoctoproject.org/git/poky.git
