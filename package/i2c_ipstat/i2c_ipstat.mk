################################################################################
#
# i2c_ipstat
#
################################################################################

I2C_IPSTAT_VERSION = 1.0.0
I2C_IPSTAT_SOURCE = v$(I2C_IPSTAT_VERSION).tar.gz
I2C_IPSTAT_SITE = https://github.com/arobinson434/i2c_ipstat/archive/refs/tags
I2C_IPSTAT_DEPENDENCIES = SSD1306_OLED_RPI bcm2835

define I2C_IPSTAT_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS="-lbcm2835 -lSSD1306_OLED_RPI" -C $(@D) all
endef

define I2C_IPSTAT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/i2c_ipstat $(TARGET_DIR)/bin
	$(INSTALL) -D -m 0755 $(@D)/S60i2c_ipstat $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
