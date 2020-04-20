## Problem Statement

This file is created in the attempt to explain what are the reasons the last overlay does
not work. Here, there are both I2C2 and SC16IS740 DTS overlays shown.

The best guess is that the last overlay, SC16IS740, does not bind to the kernel SC16IS740
driver, thus there are no signs of /dev/ttySC0 or dev/ttySC1 in the /dev directory.

### [Problem Statement] VCDBG to be implemented for the BBB and similar boards based upon TI silicons

STRONG RECCOMENDATION to Texas Instruments:
Here, the very important and powerfull tool should be placed as a Debian package for
the TI silicons/platforms to gather debug info.

The name of the tool is VCDBG. Source Code is not available, and it is placed under
the proprietary licence.

### BBB P9 header I2C2 overlay (BB-I2C2-00A0.dts file)

	$ cat BB-I2C2-00A0.dts

	/*
	 * Virtual cape for I2C2 on connector pins P9.12 P9.19 P9.20
	 *
	 * This program is free software; you can redistribute it and/or modify
	 * it under the terms of the GNU General Public License version 2 as
	 * published by the Free Software Foundation.
	 */

	/dts-v1/;
	/plugin/;

	/ {
		compatible = "ti,beaglebone", "ti,beaglebone-black", "ti,beaglebone-green";

		// identification
		part-number = "BB-I2C2";
		version = "00A0";

		// resources this cape uses
		exclusive-use =
			"P9.12",	// GPIO1_28 = GPIO 60
			"P9.19",	// i2c2_sda
			"P9.20",	// i2c2_scl
			"i2c2";		// hardware ip used

		/*
		 * Helper to show loaded overlays under: /proc/device-tree/chosen/overlays/
		 */
		fragment@0 {
			target-path="/";
			__overlay__ {

				chosen {
					overlays {
						BB-I2C2-00A0 = "Thu Mar 12 19:35:36 2020";
					};
				};
			};
		};

		/*
		 * Free up the pins used by the cape from the pinmux helpers.
		 */
		fragment@1 {
			target = <&ocp>;
			__overlay__ {
				P9_12_pinmux { status = "disabled"; };	/* GPIO 60 */
				P9_19_pinmux { status = "disabled"; };	/* i2c2_scl */
				P9_20_pinmux { status = "disabled"; };	/* i2c2_sda */
			};
		};

		fragment@2 {
			target = <&am33xx_pinmux>;
			__overlay__ {
				bb_i2c2_pins: pinmux_bb_i2c2_pins {
					pinctrl-single,pins = <
						0x078 0x1f	/* (PIN_OUTPUT_PULLUP | MUX_MODE7) P9.12 -> GPIO1_28 */
						0x17c 0x73	/* i2c2_sda, SLEWCTRL_SLOW | INPUT_PULLUP | MODE3 */
						0x178 0x73	/* i2c2_scl, SLEWCTRL_SLOW | INPUT_PULLUP | MODE3 */
					>;
					linux,phandle = <0x00000001>;
					phandle = <0x00000001>;
				};
			};
		};

		fragment@3 {
			target = <&i2c2>;
			__overlay__ {
				status = "okay";
				pinctrl-names = "default";
				pinctrl-0 = <&bb_i2c2_pins>;

				/* this is the configuration part */
				clock-frequency = <100000>;

				#address-cells = <1>;
				#size-cells = <0>;

				/* add any i2c devices on the bus here */
			};
		};
	};

After importing this overlay, the following is an outcome on the target BBB platform:

	# i2cdetect -r 2

	WARNING! This program can confuse your I2C bus, cause data loss and worse!
	I will probe file /dev/i2c-2 using receive byte commands.
	I will probe address range 0x03-0x77.
	Continue? [Y/n] y
	     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
	00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
	10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	40: -- -- -- -- -- -- -- -- -- 49 -- -- -- -- -- -- 
	50: 50 51 52 53 UU UU UU UU -- -- -- -- -- -- -- -- 
	60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	70: -- -- -- -- -- -- -- -- 

### SC16IS740 silicon overlay (BB-SC16IS740-00A0.dts file)

	$ cat BB-SC16IS740-00A0.dts

	/*
	 * SPDX-License-Identifier: GPL-2.0-only
	 *
	 * Description taken from the following pointer:
	 * sc16is7xx uart i2c kernel module problems #2241
	 * https://github.com/raspberrypi/linux/issues/2241
	 *
	 * Example taken (and adapted for NXP sc16is740 silicon) from the following pointer:
	 * https://github.com/Ysurac/raspberry_kernel_mptcp/blob/master/arch/arm/boot/dts/overlays/sc16is750-i2c-overlay.dts
	 */

	/dts-v1/;
	/plugin/;

	/ {
		compatible = "ti,beaglebone", "ti,beaglebone-black";

		fragment@0 {
			target = <&i2c2>;
			__overlay__ {
				#address-cells = <1>;
				#size-cells = <0>;
				status = "okay";

				sc16is740: sc16is740@49 {
					compatible = "nxp,sc16is740";
					reg = <0x49>; /* address */
					clocks = <&sc16is740_clk>;
					// interrupt-parent = <&gpio>;
					// interrupts = <48 2>; /* IRQ_TYPE_EDGE_FALLING */
					#gpio-cells = <2>;

					sc16is740_clk: sc16is740_clk {
						compatible = "fixed-clock";
						#clock-cells = <0>;
						clock-frequency = <1843200>;
					};
				};
			};
		};

		__overrides__ {
			int_pin = <&sc16is740>,"interrupts:0";
			addr = <&sc16is740>,"reg:0";
			xtal = <&sc16is740>,"clock-frequency:0";
		};
	};

### [Problem Statement] The problems, noticed after testing of numerous combinations

[1] The i2cdump command does not give the correct configured I2C2 space:

	# i2cdump -y 2 0x49 w

	     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
	00: 0101 0101 0000 0000 0000 0000 0000 0000 
	08: 1010 1010 0000 0000 0000 0000 0000 0000 
	10: 0101 0101 0000 0000 0000 0000 0000 0000 
	18: 0000 0000 0000 0000 0000 0000 0000 0000 
	20: 0000 0000 0000 0000 0000 0000 0000 0000 
	28: 6060 6060 0000 0000 0000 0000 0000 0000 
	30: 0000 0000 0000 0000 0000 0000 0000 0000 
	38: b8b8 b8b8 0000 0000 0000 0000 0000 0000 
	40: 4040 4040 0000 0000 0000 0000 0000 0000 
	48: 0000 0000 0000 0000 0000 0000 0000 0000 
	50: 0000 0000 0000 0000 0000 0000 0000 0000 
	58: ffff ffff ffff ffff ffff ffff ffff ffff 
	60: 0000 0000 0000 0000 0000 0000 0000 0000 
	68: 0000 0000 0000 0000 0000 0000 0000 0000 
	70: 0000 0000 0000 0000 0000 0000 0000 0000 
	78: 0606 0606 0000 0000 0000 0000 0000 0000 

Where the potential correct output should look alike:

	# i2cdump -y 2 0x49 w

	     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
	00: 01ff ff01 2dff af2d 0faf 050f 9005 fb90
	08: 0bfb 050b 4405 2844 7028 6e70 946e c694
	10: 00c6 0000 0000 0000 0000 0000 0000 0000
	18: 0000 0000 0000 0000 0000 0000 0000 0000
	20: 0000 0000 0000 0000 0000 0000 0000 0000
	28: 0000 0000 0000 0000 0000 0000 0000 0000
	30: 0000 0000 0000 0000 0000 0000 0000 0000
	38: 0000 0100 cd01 54cd 25e8 9825 04cc 4804
	40: f454 70f4 ff50 d4ff 01de ca01 00be 8800
	48: 0078 0000 0000 0000 0000 0000 0000 0000
	50: 0000 0000 0000 0000 0000 0000 0000 0000
	58: 0000 0000 0000 0000 0000 0000 0000 0000
	60: 0000 0000 0000 0000 0000 0000 0000 0000
	68: 0000 0000 0000 0000 0000 3000 2031 1307
	70: 0000 0000 0000 0000 0000 0068 0000 0000
	78: 0000 0000 0000 0000 0000 0000 0000 ff00

[2] The dtc command does not give any trace of BB-SC16IS740-00A0 overlay:

	# dtc -I fs /proc/device-tree

[3] INT1 line for the MikroBus Cape Slot 1 (P9.15) which is GPIO 48 blocks BSP in U-Boot:

https://download.mikroe.com/documents/add-on-boards/click-shields/mikrobus-cape/beagleboane-mikrobus-cape-manual-v100.pdf
https://insigntech.files.wordpress.com/2013/09/bbb_pinouts.jpg

	interrupt-parent = <&gpio>;
	interrupts = <48 2>; /* IRQ_TYPE_EDGE_FALLING */

The INT (interrupt) signal is required. And INT also requires a pull up. Maybe this
is the problem (configuring INT1 P9.15 pin as GPIO)?

Or P9.15 (INT# signal) needs a strong pull-up (circa 1.8K - 3.3K) on BBB Cape board.

The same happens changing to the MikroBus Cape Slot 2 (INT2 P9.41, which is GPIO 20),
it blocks BSP in U-Boot.

	interrupt-parent = <&gpio>;
	interrupts = <20 2>; /* IRQ_TYPE_EDGE_FALLING */

[4] Also, what about MikroBus Cape Slot 1, RST pin (P9.12)?

Should this RST pin be set to 1 for the SC16IS740 silicon? So, to set this pin
as GPIO 60 pin, output direction, value HIGH (1)?

In fact, there was an attempt to set initially P9.12 (GPIO 60) to desired direction and
value: OUT and HIGH (to assure that entire silicon SC16IS740IPW is out of RESET).

	0x078 0x1f	/* (PIN_OUTPUT_PULLUP | MUX_MODE7) P9.12 -> GPIO1_28 */

But after the overlay execution, the values are still default?!

	root@arm:/home/debian# cat /sys/class/gpio/gpio60/direction
	in (should be out)
	root@arm:/home/debian# cat /sys/class/gpio/gpio60/value
	1 (should be 1)

Not sure why???

[5] There are no entries named /dev/ttySC0 or /dev/ttySC1 in the /dev directory!

### Questions?

What would be the results with the following P8 and P9 piggyback board?

https://beagleboard.org/capes/techlab

https://beagleboard.org/static/images/PocketBeagle_TechLab_x250.png

Zoran Stojsavljevic
