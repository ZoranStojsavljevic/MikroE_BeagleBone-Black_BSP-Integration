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

### Enabling OF_OVERLAY DTS overlay config option

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

### Disabling SERIAL_DEV_CRTL_TTYPORT config option
https://cateee.net/lkddb/web-lkddb/SERIAL_DEV_CTRL_TTYPORT.html

Just disabling CONFIG_SERIAL_DEV_CTRL_TTYPORT gives a working /dev/ttySC0

	  │ Symbol: SERIAL_DEV_CTRL_TTYPORT [=n]
	  │ Type  : bool
	  │ Prompt: Serial device TTY port controller
	  │   Location:
	  │     -> Device Drivers
	  │       -> Character devices
	  │ (1)     -> Serial device bus (SERIAL_DEV_BUS [=y])
	  │   Defined at drivers/tty/serdev/Kconfig:14
	  │   Depends on: TTY [=y] && SERIAL_DEV_BUS [=y]=y

This (appears to be generic TTY driver) option is under investigation.
