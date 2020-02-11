## BUILDROOT package for building the Linux root tree

### Buildroot documentation used

Buildroot user manual:

	https://buildroot.org/downloads/manual/manual.html

[Bootlin] Buildroot practical lab training material:

	https://bootlin.com/doc/training/buildroot/buildroot-labs.pdf

[Bootlin] Buildroot Training slides:

	https://bootlin.com/doc/training/buildroot/buildroot-slides.pdf

### Buildroot Setup (by the time of writing the latest buildroot tag used)

	git clone git://git.buildroot.net/git/buildroot.git
	git branch buildroot-2019.11.1
	git checkout buildroot-2019.11.1
	ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j8 beaglebone_defconfig

### Kernels used with Buildroot

Normal vanilla kernels:

	https://mirrors.edge.kernel.org/pub
	https://mirrors.edge.kernel.org/pub/linux/kernel

Civil Infrastructure Projects Real Time (CIP RT) kernels used from:

	https://git.kernel.org/pub
	https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
	https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-4.19.98-cip19-rt7.tar.gz

## The practical Buildroot configuration

Configuration used:
```
The third solution is systemd. systemd is the new generation init system for Linux. It does far more than
traditional init programs: aggressive parallelization capabilities, uses socket and D-Bus activation for
starting services, offers on-demand starting of daemons, keeps track of processes using Linux control
groups, supports snapshotting and restoring of the system state, etc. systemd will be useful on
relatively complex embedded systems, for example the ones requiring D-Bus and services communicating
between each other. It is worth noting that systemd brings a fairly big number of large dependencies:
dbus, udev and more. For more details about systemd, see http://www.freedesktop.org/wiki/Software/systemd.
```
