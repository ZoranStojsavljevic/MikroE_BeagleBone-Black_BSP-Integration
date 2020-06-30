### Some MikroE Clicks with Linux Support

https://elinux.org/MikroEClicks_with_Linux_Support

### BBB MikroBus CAPE4

Manual for the MikroBus Cape4 is located here:

https://download.mikroe.com/documents/add-on-boards/click-shields/mikrobus-cape/beagleboane-mikrobus-cape-manual-v100.pdf

![](../Images/beaglebone-mikrobus-cape.jpg)

Please, do note the following schematics of BBB MikroBus Cape4:

![](../Images/Cape4-SPI1-SPI2.jpg)

Number of SPIs represented on this image is assymetric, so with the red circles there
are 3 SPI1 shown (1st, 2nd and 4th slots, with different CSs), and with the blue ONLY
one SPI2 (SPI0) shown (3rd slot).

Please, do note that position of MikroBuses are dependant of which SPIX is actually used!

### To Be Done

[1] MikroBus kernel.org Kernel Driver (Grey Driver) to be developed, still in the initial discussion!
[2] [1] assumes that MikroBus Cape4 flash device contains all overlays (300+) in the form of one additional binary tree...
[3] CAPE4 DTS overlay (if ?) yet to be developed. This task is of low priority!

[1] and [2] are captured here:
https://github.com/vaishnav98/mikrobus
