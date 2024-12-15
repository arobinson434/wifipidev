################################################################################
#
# SSD1306_OLED_RPI
#
################################################################################

SSD1306_OLED_RPI_VERSION = 1.6.1
SSD1306_OLED_RPI_SOURCE = $(SSD1306_OLED_RPI_VERSION).tar.gz
SSD1306_OLED_RPI_SITE = https://github.com/gavinlyonsrepo/SSD1306_OLED_RPI/archive/refs/tags
SSD1306_OLED_RPI_LICENSE = GPL-3.0
SSD1306_OLED_RPI_LICENSE_FILE = LICENSE
SSD1306_OLED_RPI_INSTALL_STAGING = YES
SSD1306_OLED_RPI_DEPENDENCIES = bcm2835

define SSD1306_OLED_RPI_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) pre-build
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) CCFLAGS=-I$(@D)/include/ SSD1306_OLED_RPI
endef

define SSD1306_OLED_RPI_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/include/SSD1306_OLED*.hpp $(STAGING_DIR)/usr/include/
	$(INSTALL) -D -m 0755 $(@D)/libSSD1306_OLED_RPI.so.1.0 $(STAGING_DIR)/usr/lib/
	ln -sf libSSD1306_OLED_RPI.so.1.0 $(STAGING_DIR)/usr/lib/libSSD1306_OLED_RPI.so.1
	ln -sf libSSD1306_OLED_RPI.so.1.0 $(STAGING_DIR)/usr/lib/libSSD1306_OLED_RPI.so
endef

define SSD1306_OLED_RPI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libSSD1306_OLED_RPI.so.1.0 $(TARGET_DIR)/usr/lib/
	ln -sf libSSD1306_OLED_RPI.so.1.0 $(TARGET_DIR)/usr/lib/libSSD1306_OLED_RPI.so.1
	ln -sf libSSD1306_OLED_RPI.so.1.0 $(TARGET_DIR)/usr/lib/libSSD1306_OLED_RPI.so
endef

$(eval $(generic-package))
