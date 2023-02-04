#!/bin/bash
echo Flashing MCUs!
#sudo service klipper stop
cd ~/klipper
#echo "Pulling updates"
#git pull

echo "Building Linux firmware"
make clean KCONFIG_CONFIG=.config_linux
make menuconfig KCONFIG_CONFIG=.config_linux
make KCONFIG_CONFIG=.config_linux
#read -p "Linux firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=.config_linux


echo "Building SKR1.4 firmware"
make clean KCONFIG_CONFIG=.config_skr1.4
#make menuconfig KCONFIG_CONFIG=.config_skr1.4
make KCONFIG_CONFIG=.config_skr1.4

#read -p "SKR firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

echo "Flashing SKR1.4 1"
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_lpc1769_1CD0000E871C4AAF233B7C5DC22000F5-if00 KCONFIG_CONFIG=.config_skr1.4 || make flash KCONFIG_CONFIG=.config_skr1.4 FLASH_DEVICE=1d50:6015 

#make flash FLASH_DEVICE=1d50:6015 KCONFIG_CONFIG=.config_skr1.4
#./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_lpc1769_05800010871C4AAFAF437C5DC42000F5-if00 btt-skr-turbo-v1.4
ls -l /dev/serial/by-id
echo "Flashing SKR1.4 2"
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_lpc1769_05800010871C4AAFAF437C5DC42000F5-if00 KCONFIG_CONFIG=.config_skr1.4 || make flash KCONFIG_CONFIG=.config_skr1.4 FLASH_DEVICE=1d50:6015 

#./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_lpc1769_1CD0000E871C4AAF233B7C5DC22000F5-if00 btt-skr-turbo-v1.4

echo "Building RP2040 firmware"
make clean KCONFIG_CONFIG=.config_rp2040
make menuconfig KCONFIG_CONFIG=.config_rp2040
make KCONFIG_CONFIG=.config_rp2040

echo "Flashing MCU led"
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_rp2040_E6605838832A702E-if00 KCONFIG_CONFIG=.config_rp2040  
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_rp2040_E661347507306821-if00 KCONFIG_CONFIG=.config_rp2040  

#echo "Starting Klipper"
#sudo service klipper start

