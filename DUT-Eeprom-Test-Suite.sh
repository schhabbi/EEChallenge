#!/bin/bash

################################################################################
#############  Test - 3 (Write and read into EEPROM)  ##############
################################################################################

echo This is EEPROM test utility!

#
# Create test binary file and fill it with 8000 random bytes
#
touch TestFileEeprom.bin
for i in {1..8000}
    do
        echo $((RANDOM % 10)) >> TestFileEeprom.bin
    done

#
# Write file contents into EEPROM
#
dd if=TestFileEeprom.bin of=/sys/bus/i2c/i2c1/devices/eeprom bs=1 count=8000

#
# Read contents from EEPROM into file
#
cat /sys/bus/i2c/i2c1/devices/eeprom | od -x >> /ReadEepromData.bin

#
# Compare files
#
cmp -n 8000 TestFileEeprom.bin ReadEepromData.bin
CmpStatus=$?
if [ "$CmpStatus" -ne "0" ]
then
    echo "Files are not identical. Test has failed."
    else
    echo "Files are identical. Test has passed."
fi
