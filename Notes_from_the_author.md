### Notes from the author

The BBB board Revision used is REV. A (0x0A5C).

	root@arm:/home/debian# /opt/scripts/tools/version.sh | grep eeprom
	eeprom:[A335BNLT0A5C2813BBBK4802]

Please, do note that this repo is in PRELIMINARY design stage, and it is not yet completed. It is released to the
public as General Archtecture for MikroE CLICK design, in attempt to integrate CLICK HW to BeagleBone Black as the
extension for the BBB usage.

Any comments, addendums, design considerations, system and application code written to drive CLICKs, any missing
schematic, are more than welcome since this repo is a living repo, intended to be updated by interesting examples,
and to be completed ASAP to reflect the CLICK integration with BBB.

Once this file is removed from this repo, this will be the sign that this repo is mature enough to be taken as
complete design and architecture for BBB, extended by MikroE CLICKs

This repo shows the general guidelines, how to add CLICK boards using BBB board based upon TI armv7 am335x Sitara
silicon.

The major overlay examples could be found in the following folder/directory:

.../MikroE_BeagleBone-Black_BSP-Integration/BBB-debian_buster/overlay_examples/

	[vuser@fedora31-ssd overlay_examples]$ ls -al
	total 44
	drwxr-xr-x. 8 vuser vboxusers 4096 Apr 26 12:32 .
	drwxr-xr-x. 3 vuser vboxusers 4096 Apr 26 06:56 ..
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 26 06:14 bb_cape4_pru
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 26 07:44 i2c2_pcf8583 <<==== Working Example
	drwxr-xr-x. 3 vuser vboxusers 4096 Apr 26 07:18 i2c2_sc16is740 <<==== Working Example
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 26 12:26 Images
	-rw-r--r--. 1 vuser vboxusers 1320 Apr  8 10:41 KERNEL.md
	-rw-r--r--. 1 vuser vboxusers 2153 Apr 26 11:57 README.md
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 26 11:53 spi0_enc28j60 <<=== Working Example
	drwxr-xr-x. 2 vuser vboxusers 4096 Apr 24 03:08 spi0_sc16is740 <<=== Working Example
	-rw-r--r--. 1 vuser vboxusers 3304 Apr 26 06:31 uEnv.txt

Working CLICK examples so far:

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) i2c2_pcf8583 <<==== Working Example

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) i2c2_sc16is740 <<=== Working Example

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) spi0_enc28j60 <<=== Working Example

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) spi0_sc16is740 <<=== Working Example

Please, do note that file uEnv.txt is a master example, used in all configs with proper overlay file(s) enabled!

Zoran Stojsavljevic
