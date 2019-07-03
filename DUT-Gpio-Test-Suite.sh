#!/bin/bash

echo This is GPIO test utility!

# Variable declaration
declare -i Temp

# Export all the GPIOs
for i in {1..10}
    do
        echo $i > /sys/class/gpio/export
    done

################################################################################
#############  Test - 1 (Odd pins - Inputs; Even pins - Outputs)  ##############
################################################################################

#
# Set configuration of pins 1, 3, 5, 7 & 9 as inputs
#
for j in 1 3 5 7 9
    do
        echo "in" > /sys/class/gpio/gpio$j/direction
    done

#
# Set configuration of pins 2, 4, 6, 8 & 10 as outputs
#
for j in 2 4 6 8 10
    do
        echo "out" > /sys/class/gpio/gpio$j/direction
    done

#
# Set state of pins 2, 4, 6, 8 & 10 to high and read states of 1, 3, 5, 7 & 9
#
for i in 2 4 6 8 10
    do
        echo 1 > /sys/class/gpio/gpio$i/value
    done
        
for i in 1 3 5 7 9
    do
        Temp=i+1
        if ($(cat /sys/class/gpio/gpio$i/value) == 1 )
            then
                echo GPIO$i is tested as output - PASS
                echo GPIO$Temp is tested as input - PASS
            else
                echo GPIO$i is tested as output - FAIL
                echo GPIO$Temp is tested as input - FAIL
        fi
    done

################################################################################
#############  Test - 2 (Odd pins - Outputs; Even pins - Inputs)  ##############
################################################################################

#
# Set configuration of pins 1, 3, 5, 7 & 9 as outputs
#
for j in 1 3 5 7 9
    do
        echo "out" > /sys/class/gpio/gpio$j/direction
    done

#
# Set configuration of pins 2, 4, 6, 8 & 10 as inputs
#
for j in 2 4 6 8 10
    do
        echo "in" > /sys/class/gpio/gpio$j/direction
    done

#
# Set state of pins 1, 3, 5, 7 & 9 to high and read states of 2, 4, 6, 8 & 10
#
for i in 1 3 5 7 9
    do
        echo 1 > /sys/class/gpio/gpio$i/value
    done

for i in 2 4 6 8 10
    do
        Temp=i-1
        if ($(cat /sys/class/gpio/gpio$i/value) == 1 )
            then
                echo GPIO$i is tested as input - PASS
                echo GPIO$Temp is tested as output - PASS
            else
                echo GPIO$i is tested as input - FAIL
                echo GPIO$Temp is tested as output - FAIL
        fi
    done
