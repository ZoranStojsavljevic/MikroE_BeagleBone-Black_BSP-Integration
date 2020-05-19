### The UART-I2C-SPI-CLICK Description (UART-SPI PART)

https://media.digikey.com/pdf/Data%20Sheets/MikroElektronika%20PDFs/MIKROE-3349_Web.pdf

BB-SPI0-SC16IS740.dts ==>> symbolic overlay representation which needs to be pre-processed
with cpp (gcc).

BB-SPI0-SC16IS740-00A0.dts ==>> does not need pre-processing - convenient for the target
environment.

The Click board™ is equipped with a number of SMD jumpers. There are five jumpers grouped
under the COMM SEL label, used to select one of two available interfaces: SPI, and I2C. By
moving all the jumpers at the desired position, the user can select the interface used for
the communication with the host MCU. It is advisable to move all the jumpers at once to
either left (SPI) or the right (I2C) position.

All the jumpers/0 Ohm resistors are positioned on the left side (SPI interface).

Since SPI0 is used, MikroBus 3 must be used (MikroBus 3 is the only one using SPI0).

https://static5.arrow.com/pdfs2/2019/4/16/3/19/27/650974/mikroe_/auto/uart-i2c-spi-click-schematic-v100.pdf

https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black_BSP-Integration/blob/master/BBB-debian_buster/overlay_examples/Images/uart-i2c-spi-click-schematic-v100.pdf

All the rest described here (applicable parts):
https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black_BSP-Integration/tree/master/BBB-debian_buster/overlay_examples/spi0_enc28j60

### Issues, which were solved before getting /dev/ttySC0 (wuth the unselfish help of Robert C Nelson)

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

Just disabling CONFIG_SERIAL_DEV_CTRL_TTYPORT gives a working /dev/ttySC0 :

	  │ Symbol: SERIAL_DEV_CTRL_TTYPORT [=n]
	  │ Type  : bool
	  │ Prompt: Serial device TTY port controller
	  │   Location:
	  │     -> Device Drivers
	  │       -> Character devices
	  │ (1)     -> Serial device bus (SERIAL_DEV_BUS [=y])
	  │   Defined at drivers/tty/serdev/Kconfig:14
	  │   Depends on: TTY [=y] && SERIAL_DEV_BUS [=y]=y

The description of the CONFIG_SERIAL_DEV_CTRL_TTYPORT flag is given here:

https://cateee.net/lkddb/web-lkddb/SERIAL_DEV_CTRL_TTYPORT.html

#### Final Results

As the final result of correctly formatted overlay is the following target command!

	root@arm:/lib/firmware# dmesg | grep serial
	[    1.655013] 44e09000.serial: ttyS0 at MMIO 0x44e09000 (irq = 29, base_baud = 3000000) is a 8250
	[    1.672740] 48022000.serial: ttyS1 at MMIO 0x48022000 (irq = 35, base_baud = 3000000) is a 8250
	[    1.673597] 48024000.serial: ttyS2 at MMIO 0x48024000 (irq = 36, base_baud = 3000000) is a 8250
	[    1.674503] 481a6000.serial: ttyS3 at MMIO 0x481a6000 (irq = 49, base_baud = 3000000) is a 8250
	[    1.675449] 481a8000.serial: ttyS4 at MMIO 0x481a8000 (irq = 50, base_baud = 3000000) is a 8250
	[    1.676271] 481aa000.serial: ttyS5 at MMIO 0x481aa000 (irq = 51, base_baud = 3000000) is a 8250
	[    1.809545] serial serial0: tty port ttySC0 registered
	[   18.742146] systemd[1]: Created slice system-serial\x2dgetty.slice.
	root@arm:/lib/firmware#

	root@arm:/home/debian# ls -al /dev | grep ttySC0
	crw-rw----  1 root dialout 245,   0 May 18 19:02 ttySC0
	root@arm:/home/debian# uname -a
	Linux arm 5.4.24+ #2 PREEMPT Mon May 18 10:15:36 CEST 2020 armv7l GNU/Linux
	root@arm:/home/debian#
