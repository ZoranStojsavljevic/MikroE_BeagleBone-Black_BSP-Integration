### Current Problems

An interim commit, with some overlay sketches, far from the final solution.

There are problems with basic overlay structures, and this must be solved as priority.

	root@arm:/lib/firmware# ls -al /proc/device-tree/chosen/overlays/
	total 0
	drwxr-xr-x 2 root root  0 Apr 24 01:02 .
	drwxr-xr-x 3 root root  0 Apr 24 01:02 ..
	-r--r--r-- 1 root root 25 Apr 24 01:02 AM335X-PRU-RPROC-4-19-TI-00A0
	-r--r--r-- 1 root root 25 Apr 24 01:02 BB-ADC-00A0
	-r--r--r-- 1 root root 25 Apr 24 01:02 BB-BONE-eMMC1-01-00A0
	-r--r--r-- 1 root root 25 Apr 24 01:02 BB-HDMI-TDA998x-00A0
	-r--r--r-- 1 root root  9 Apr 24 01:02 name

Here is the output with basic overlay structure, shown above!

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
