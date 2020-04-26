### Current Problems

Another interim commit, with some overlay sketches, close to the final solution.

Here is the command dtc -I fs /proc/device-tree output with basic root Device Tree structure!

	root@arm:/home/debian# dtc -I fs /proc/device-tree
	<stdout>: Warning (status_is_string): /ocp/interconnect@48000000/segment@0/target-module@40000:status: property is not a string
	<stdout>: Warning (status_is_string): /ocp/interconnect@48000000/segment@0/target-module@40000/timer@0:status: property is not a string
	<stdout>: Warning (status_is_string): /ocp/interconnect@44c00000/segment@200000/target-module@31000:status: property is not a string

	...

	<stdout>: Warning (gpios_property): /leds/led3:gpios: cell 0 is not a phandle reference
	<stdout>: Warning (gpios_property): /clk_mcasp0:enable-gpios: cell 0 is not a phandle reference
	/dts-v1/;

	/ {
	Segmentation fault

U-Boot used:

	U-Boot 2019.04 (Mar 12 2020 - 08:25:14 +0100)

	CPU  : AM335X-GP rev 2.0
	I2C:   ready
	DRAM:  512 MiB
	No match for driver 'omap_hsmmc'
	No match for driver 'omap_hsmmc'
	Some drivers were not found
	Reset Source: Global external warm reset has occurred.
	Reset Source: Power-on reset has occurred.
	RTC 32KCLK Source: External.
	MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
	Loading Environment from EXT4... ** File not found /boot/uboot.env **

	** Unable to read "/boot/uboot.env" from mmc0:1 **
	Board: BeagleBone Black
	<ethaddr> not set. Validating first E-fuse MAC
	BeagleBone Black:
	BeagleBone: cape eeprom: i2c_probe: 0x54:
	BeagleBone: cape eeprom: i2c_probe: 0x55:
	BeagleBone: cape eeprom: i2c_probe: 0x56:
	BeagleBone: cape eeprom: i2c_probe: 0x57:
	Net:   eth0: MII MODE
	cpsw, usb_ether
	Press SPACE to abort autoboot in 0 seconds

U-Boot Factory flash parameters:

	=> i2c md 0x50 0.2 0x10
	0000: aa 55 33 ee 41 33 33 35 42 4e 4c 54 30 41 35 43    .U3.A335BNLT0A5C

	=> print
	board=am335x
	board_eeprom_header=undefined
	board_name=A335BNLT
	board_rev=0A5C
	board_serial=2813BBBK4802

## The board Revision is A (0x0A5C), and MUST be at least Revision C (0x000C)!
## This is why the root Device Tree does NOT work, produces Segmentation fault!
