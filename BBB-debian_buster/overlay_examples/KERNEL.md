## Common BeagleBone Black Linux kernel requirements

Please, do note that the customized kernel must be built in order to achieve the desired
functionality for the most MikroE CLICK boards:

	[1] The standard defconfig .config  will change in order to include CLICK silicon
	    driver options
	[2] In most the cases the Device Tree Source (DTS) device fragment either will be:
		[A] Included with the standard  .../arch/arm/boot/dts/am335x-boneblack.dts
		[B] Needs to be imported to the .../arch/arm/boot/dts/am335x-boneblack.dts
		[C] Needs to be included as DTS overlay

These requirements are calling for the customized kernel, which does NOT come out of the box!

### Changing current kernel .config (to include DTS overlay as part of the kernel)

In the most common case used (to added kernel device driver having its own DTS representation),
DTS overlay is used. The kernel DTS overlay representation is the following:

	  │ Symbol: OF_OVERLAY [=y]
	  │ Type  : bool
	  │ Prompt: Device Tree overlays
	  │   Location:
	  │     -> Device Drivers
	  │ (2)   -> Device Tree and Open Firmware support (OF [=y])
	  │   Defined at drivers/of/Kconfig:92
	  │   Depends on: OF [=y]

They will appear as the following CONFIG options in the .config :

	CONFIG_OF_OVERLAY=y
	# CONFIG_OVERLAY_FS is not set
