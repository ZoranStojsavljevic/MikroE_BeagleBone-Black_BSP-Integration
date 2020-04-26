## MASTER EXAMPLE: MICROE-3349: I2C/ISP to serial I/F click

CLICK SPI/I2C to Serial Bridge Systems and Application SW, showing the CLICK Referent Design:

https://media.digikey.com/pdf/Data%20Sheets/MikroElektronika%20PDFs/MIKROE-3349_Web.pdf

#### Step 1: Click HW used in the master example
![](https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black-BSP_Integration/blob/master/MikroE_BBB_CLICK_Design/Images/MIKROE-3349.jpg)
Please, find the click description from the above image:

The design of the UART I2C/SPI click is based around two integrated circuits. The first IC is the
SC16IS740, an I2C/SPI to UART interface, 64 bytes of transmit and receive FIFOs, and IrDA SIR
built-in support, from NXP. This IC bridges the data communication between the two interfaces,
offering many additional features, such as the support for the automatic hardware and software
flow control, RS-485 support and software reset of the UART. The SC16IS740 can be configured over
the SPI or I2C interface, by writing values to a 16C450 compatible set of registers. Maintaining
the backward compatibility with the widely popular 16C450 asynchronous communications element
(ACE). This allows the software to be easily written or ported from another platform.

#### Step 2: General Requirements

In order to verify how the projected architecture works, there is a requirement to do the most
simplified case in order to prove the architecture and design: MIKROE-3349 I2C to UART bridge.

#### Step 3: HW Considerations

The mikroBUS looks like the following:
![](https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black-BSP_Integration/blob/master/MikroE_BBB_CLICK_Design/Images/mikroBUS.jpg)
As seen from the picture, there are only 4+1 signals required from the BBB expansion connector
to the mikroBUS (shown in the following table):

	[1] VCC +5V
	[2] GND
	[3] SDC
	[4] SDA
	[5] INT (if possible)

#### Step 4: Changing current kernel .config (to include SC16IS7xx driver as part of the kernel)

Please, read file KERNEL.md for the better Linux kernel requirements' understanding:

https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black-BSP_Integration/blob/master/BBB-debian_buster/overlay_examples/KERNEL.md

These requirements call for the customized kernel, which does NOT come out of the box!

The DTS method used in this example is DTS overlay.

Please, execute the following command in the root tree source of the currently used BBB Linux kernel:

Change kernel .config (original defconfig used to build .config is omap2plus_defconfig):

	Debian:
	ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 menuconfig

	Fedora:
	ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 menuconfig
	ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j8 menuconfig (if Linaro cross GCC compiler installed)

Please, find the following options and add them to be included in the kernel:

	  │ Symbol: SERIAL_SC16IS7XX [=y]
	  │ Type  : tristate
	  │ Prompt: SC16IS7xx serial support
	  │   Location:
	  │     -> Device Drivers
	  │       -> Character devices
	  │ (1)     -> Serial drivers
	  │   Defined at drivers/tty/serial/Kconfig:1083
	  │   Depends on: TTY [=y] && HAS_IOMEM [=y] && (SPI_MASTER [=y] && !I2C [=y] || I2C [=y])
	  │   Selects: SERIAL_CORE [=y]
	  │
	  │
	  │ Symbol: SERIAL_SC16IS7XX_CORE [=y]
	  │ Type  : tristate
	  │   Defined at drivers/tty/serial/Kconfig:1080
	  │   Depends on: TTY [=y] && HAS_IOMEM [=y]
	  │   Selected by [y]:
	  │   - SERIAL_SC16IS7XX_I2C [=y] && TTY [=y] && HAS_IOMEM [=y] && I2C [=y] && SERIAL_SC16IS7XX [=y]
	  │   - SERIAL_SC16IS7XX_SPI [=y] && TTY [=y] && HAS_IOMEM [=y] && SPI_MASTER [=y] && SERIAL_SC16IS7XX [=y]
	  │
	  │
	  │ Symbol: SERIAL_SC16IS7XX_I2C [=y]
	  │ Type  : bool
	  │ Prompt: SC16IS7xx for I2C interface
	  │   Location:
	  │     -> Device Drivers

They will appear as the following CONFIG options in the .config :

	CONFIG_SERIAL_SC16IS7XX_CORE=y
	CONFIG_SERIAL_SC16IS7XX=y
	CONFIG_SERIAL_SC16IS7XX_I2C=y
	CONFIG_SERIAL_SC16IS7XX_SPI=y

For the initial testing, the following configuration should be enough (minimal configuration):

	CONFIG_SERIAL_SC16IS7XX_CORE=y
	CONFIG_SERIAL_SC16IS7XX=y
	CONFIG_SERIAL_SC16IS7XX_I2C=y
	# CONFIG_SERIAL_SC16IS7XX_SPI is not set

#### Step 5: Changing current kernel .config (to include DTS overlay as part of the kernel)

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

Please, proceed to the master README.md to find instructions how to make customized kernel:

https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black-BSP_Integration/blob/master/README.md

#### Step 6: The SC16IS740 Device Tree Source as DTS overlay

From the kernel documentation (using BootLin repos):
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt

The overlays directory should be created in .../arch/arm/boot/ directory as:
.../arch/arm/boot/overlays/

and there file created/copied:
.../arch/arm/boot/overlays/BB-SC16IS740-00A0.dts

The BB-SC16IS740-00A0.dts file looks something like:

#### BB-SC16IS740 Silicon Overlay

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
					interrupt-parent = <&gpio>;
					interrupts = <48 2>; /* IRQ_TYPE_EDGE_FALLING */
					gpio-controller;
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

#### Step 7: Compiling and installing BB-SC16IS740-00A0.dts using DTC built-in kernel tree itself

BB-SC16IS740-00A0.dts should reside at kernel tree location: .../arch/arm/boot/overlays/

Please, compile and install BB-SC16IS740-00A0.dts using built-in DTC compiler to kernel itself:

	$ dtc -@ -I dts -O dtb -o BB-SC16IS740-00A0.dtbo BB-SC16IS740-00A0.dts
	$ sudo scp BB-SC16IS740-00A0.dtbo debian@<BBB IP address>:/lib/firmware
