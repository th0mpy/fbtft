ifneq ($(KERNELRELEASE),)
# kbuild part of makefile

# Optionally, include config file to allow out of tree kernel modules build
-include $(src)/.config

# Core module
obj-$(CONFIG_FB_TFT)             += fbtft.o
fbtft-y                          += fbtft-core.o fbtft-sysfs.o fbtft-bus.o fbtft-io.o

# drivers
obj-$(CONFIG_FB_TFT_AGM1264K_FL) += fb_agm1264k-fl.o
obj-$(CONFIG_FB_TFT_BD663474)    += fb_bd663474.o
obj-$(CONFIG_FB_TFT_HX8340BN)    += fb_hx8340bn.o
obj-$(CONFIG_FB_TFT_HX8347D)     += fb_hx8347d.o
obj-$(CONFIG_FB_TFT_HX8353D)     += fb_hx8353d.o
obj-$(CONFIG_FB_TFT_ILI9320)     += fb_ili9320.o
obj-$(CONFIG_FB_TFT_ILI9325)     += fb_ili9325.o
obj-$(CONFIG_FB_TFT_ILI9340)     += fb_ili9340.o
obj-$(CONFIG_FB_TFT_ILI9341)     += fb_ili9341.o
obj-$(CONFIG_FB_TFT_ILI9481)     += fb_ili9481.o
obj-$(CONFIG_FB_TFT_ILI9486)     += fb_ili9486.o
obj-$(CONFIG_FB_TFT_ILI9488)     += fb_ili9488.o
obj-$(CONFIG_FB_TFT_PCD8544)     += fb_pcd8544.o
obj-$(CONFIG_FB_TFT_RA8875)      += fb_ra8875.o
obj-$(CONFIG_FB_TFT_S6D02A1)     += fb_s6d02a1.o
obj-$(CONFIG_FB_TFT_S6D1121)     += fb_s6d1121.o
obj-$(CONFIG_FB_TFT_SSD1289)     += fb_ssd1289.o
obj-$(CONFIG_FB_TFT_SSD1306)     += fb_ssd1306.o
obj-$(CONFIG_FB_TFT_SSD1331)     += fb_ssd1331.o
obj-$(CONFIG_FB_TFT_SSD1351)     += fb_ssd1351.o
obj-$(CONFIG_FB_TFT_ST7735R)     += fb_st7735r.o
obj-$(CONFIG_FB_TFT_TINYLCD)     += fb_tinylcd.o
obj-$(CONFIG_FB_TFT_TLS8204)     += fb_tls8204.o
obj-$(CONFIG_FB_TFT_UC1701)      += fb_uc1701.o
obj-$(CONFIG_FB_TFT_UPD161704)   += fb_upd161704.o
obj-$(CONFIG_FB_TFT_WATTEROTT)   += fb_watterott.o
obj-$(CONFIG_FB_FLEX)            += flexfb.o

# Device modules
obj-$(CONFIG_FB_TFT_FBTFT_DEVICE) += fbtft_device.o

else
# normal makefile
KDIR ?= /lib/modules/`uname -r`/build

default: .config
	$(MAKE) -C $(KDIR) M=$$PWD modules

.config:
	grep config Kconfig | cut -d' ' -f2 | sed 's@^@CONFIG_@; s@$$@=m@' > .config

install:
	$(MAKE) -C $(KDIR) M=$$PWD modules_install


clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions \
	       modules.order Module.symvers

endif
