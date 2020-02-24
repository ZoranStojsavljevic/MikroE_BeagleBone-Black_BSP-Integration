## Common BeagleBone Black Linux kernel requirements

Please, do note that the customized kernel must be built in order to achieve the desired
functionality for the most MikroE CLICK boards:

	[1] The standard defconfig .config  will change in order to include CLICK silicon
	    driver options
	[2] In most the cases the Device Tree Source (DTS) file either will be:
		[A] Included with the standard  .../arch/arm/boot/dts/am335x-boneblack.dts
		[B] Needs to be imported to the .../arch/arm/boot/dts/am335x-boneblack.dts
		[C] Needs to be included as DTS overlay

These requirements are calling for the customized kernel, which does NOT come out of the box!
