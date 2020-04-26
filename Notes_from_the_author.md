### Notes from the author

Please, do note that this repo is in PRELIMINARY design stage, and it is not yet completed. It is released to the
public as General Archtecture for MicroElektronica CLICK design, in attempt to integrate CLICK HW to BeagleBone
Black as the extension for the BBB usage.

Any comments, addendums, design considerations, system and application code written to drive CLICKs, any schematic,
connecting BBB and CLICKs (SPI/I2C mikroBUS bridge), are more than welcome since this repo is a living repo,
intended to be updated by interesting examples, and to be completed ASAP to reflect the CLICK integration with BBB.

Once this file is removed from this repo, this will be the sign that this repo is mature enough to be taken as
complete design and architecture for BBB, extended by MikroE CLICKs

This repo shows the general guidelines, how to add CLICK boards using BBB board based upon TI armv7 am335x Sitara
silicon.

The major overlay examples could be found in the following folder/directory:

.../MikroE_BeagleBone-Black_BSP-Integration/BBB-debian_buster/overlay_examples/

	[vuser@fedora31-ssd overlay_examples]$ ls -al
	total 40
	drwxr-xr-x. 7 vuser vboxusers 4096 Apr 26 06:54 .
	drwxr-xr-x. 3 vuser vboxusers 4096 Apr 26 06:56 ..
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 26 06:14 bb_cape4_pru
	drwxr-xr-x. 3 vuser vboxusers 4096 Apr 23 08:13 eth_enc28j60
	drwxr-xr-x. 3 vuser vboxusers 4096 Apr 26 06:42 i2c2_sc16is740
	-rw-r--r--. 1 vuser vboxusers 1320 Apr  8 10:41 KERNEL.md
	-rw-r--r--. 1 vuser vboxusers 2614 Apr 26 05:17 README.md
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 19 13:42 rtc_pcf8583
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 24 03:08 spi0_sc16is740
	-rw-r--r--. 1 vuser vboxusers 3304 Apr 26 06:31 uEnv.txt

Please, do note that file uEnv.txt is a master example, used in all configs with proper overlay file(s) enabled!

Zoran Stojsavljevic
