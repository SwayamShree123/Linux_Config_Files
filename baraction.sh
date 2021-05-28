#!/usr/bin/bash

# INTERNAL=$(cat /sys/class/power_supply/BAT1/capacity)
# STATUS=$(cat /sys/class/power_supply/BAT1/status)
# while true; do
# 	echo "Battery Status: $INTERNAL% $STATUS"
# 	sleep 5s
# done

## RAM
mem() {
	  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 /1024.0 }'`
	    echo -e " $mem"
 }

## CPU
cpu() {
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	 cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	 echo -e " $cpu%"
 }

##BATTERY STATUS
bat() {

	INTERNAL=$(cat /sys/class/power_supply/BAT1/capacity)
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	if [ "$STATUS" = "Unknown" ]; then
	echo " $INTERNAL% | Not Charging"
	else
	echo " $INTERNAL% $STATUS"
	fi
}	

## WEATHER 
wea() {
	WEATHER=$(curl -s wttr.in?format=%t)
	echo " $WEATHER"
 }


SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs

while :; do
	echo "+@fg=1;+@fn=1;+@fn=0;$(mem)+@fg=6; |+@fg=2; +@fn=1;+@fn=0;$(cpu)+@fg=6; |+@fg=3; +@fn=1;🔋︁+@fn=0;$(bat)+@fg=6; |+@fg=4; +@fn=1;☀+@fn=0;$(wea) "
	    sleep $SLEEP_SEC
	done


