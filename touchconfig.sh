#Device name.  Use "xinput --list" to list all devices
NAME="FT5406 memory based driver"

#NORMAL (0 degrees)
#xinput set-prop "$NAME" "Evdev Axis Inversion" 0, 0
#xinput set-prop "$NAME" "Evdev Axes Swap" 0

#LEFT (270 degrees)
xinput set-prop "$NAME" "Evdev Axis Inversion" 1, 0
xinput set-prop "$NAME" "Evdev Axes Swap" 1
