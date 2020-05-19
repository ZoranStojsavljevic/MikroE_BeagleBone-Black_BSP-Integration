## Current Problems

	The BBB board Revision used is REV. A (0x0A5C).

#### SC16IS7xx Driver Problem
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/tty/serial/sc16is7xx.c?h=v5.7-rc5

The problem in details is described here:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/tty/serial/sc16is7xx.c?h=next-20200515&id=4a37c0fcf5d403e7d9f5309ea970ea3c9074b5d8

```
author	Gustavo A. R. Silva <gustavo@embeddedor.com>	2020-02-12 18:46:11 -0600
committer	Greg Kroah-Hartman <gregkh@linuxfoundation.org>	2020-02-13 12:00:23 -0800
commit	4a37c0fcf5d403e7d9f5309ea970ea3c9074b5d8 (patch)
tree	36ec2b06790facbd2991ffc6423ea8aa463a792c /drivers/tty/serial/sc16is7xx.c
parent	2f202d03a5785ffaf894f9503193a3767ff88d88 (diff)
download	linux-next-4a37c0fcf5d403e7d9f5309ea970ea3c9074b5d8.tar.gz
serial: sc16is7xx: Replace zero-length array with flexible-array member
The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Link: https://lore.kernel.org/r/20200213004611.GA8748@embeddedor.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Diffstat (limited to 'drivers/tty/serial/sc16is7xx.c')
-rw-r--r--	drivers/tty/serial/sc16is7xx.c	2	

1 files changed, 1 insertions, 1 deletions
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7d3ae31cc720..06e8071d5601 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -329,7 +329,7 @@ struct sc16is7xx_port {
	struct task_struct		*kworker_task;
	struct kthread_work		irq_work;
	struct mutex			efr_lock;
-	struct sc16is7xx_one		p[0];
+	struct sc16is7xx_one		p[];
 };

static unsigned long sc16is7xx_lines;
```
#### SERIAL_DEV_CRTL_TTYPORT config option

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

#### Discourage use of fdtdump
https://git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=548aea2c436ab47ff09ba9ec7e902e971bbc399c

#### Discourage use of dtc -I fs /proc/device-tree

Another interim commit, with some overlay sketches, close to the final solution.

Here is the command: dtc -I fs /proc/device-tree output with basic root Device Tree structure!

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

#### U-BOOT used

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
