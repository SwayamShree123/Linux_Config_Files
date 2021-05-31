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
	    echo -e " $mem"
 }

## CPU
cpu() {
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	 cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	 echo -e " $cpu%"
 }

##BATTERY STATUS
bat() {

	INTERNAL=$(cat /sys/class/power_supply/BAT1/capacity)
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	if [ "$STATUS" = "Unknown" ]; then
	echo " $INTERNAL%"
	fi
	if [ "$STATUS" = "Charging" ]; then
	echo " $INTERNAL%"	
	else
	echo " $INTERNAL%"
	fi
}	

## WEATHER 
wea() {
	$(curl -s wttr.in?format=j1 > ~/scripts/weather.txt)
	$(head -25 ~/scripts/weather.txt > ~/scripts/weather2.txt)
	wthr=$(cat ~/scripts/weather2.txt | grep -i value | awk '{print $2}' | tr -d '""' | tr -d ',')
	temp=$(cat ~/scripts/weather2.txt | grep -i temp_f | awk '{print $2}' | tr -d '""' | tr -d ',')
	echo "杖 $wthr $temp"
 }

## BRIGHTNESS
bri() {
	read c < /sys/class/backlight/intel_backlight/actual_brightness
	read d < /sys/class/backlight/intel_backlight/max_brightness
	brightness=$((100*$c/$d))
	echo " $brightness%"
}

## VOLUME
vol() {
	mixer=$(amixer -D pulse get Master | grep 'Front Left:' | cut -d ' ' -f 7 | tr -d '[]')
	echo " $mixer"
	}

## WIFI
wi() {
	stat=$(nmcli general status | grep connected | awk '{print $1}')
	if [ "$stat" = "connected" ]; then
	echo ""
	else
	echo "睊"
	fi
}

## BLUETOOTH
blu() {
	con=$(bluetoothctl show | grep -i powered | awk '{print $1}')
	if [ "$con" = "yes" ]; then
	echo ""
	else
	echo ""
	fi
}
SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs

while :; do
	echo "+@fg=6;| $(wi)  $(blu)                                            +@fg=1; $(mem)+@fg=6; |+@fg=2; $(cpu)+@fg=6; |+@fg=3; $(bat)+@fg=6; |+@fg=4; $(bri)+@fg=6; |+@fg=2; $(vol)                +@fg=1; $(wea)F +@fg=6;|"
	    sleep $SLEEP_SEC
	done

