#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

# Available Styles
# >> Created and tested on : rofi 1.6.0-1
#
# column_circle     column_square     column_rounded     column_alt
# card_circle     card_square     card_rounded     card_alt
# dock_circle     dock_square     dock_rounded     dock_alt
# drop_circle     drop_square     drop_rounded     drop_alt
# full_circle     full_square     full_rounded     full_alt
# row_circle      row_square      row_rounded      row_alt

theme="drop_square"
dir="$HOME/.config/rofi/powermenu"


uptime=$(uptime -p | sed -e 's/up //g')

# rofi_command="rofi -theme $dir/$theme"
rofi_command="rofi"

# Options
shutdown=" ShutDown"
reboot=" Restat"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"


# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout\nUpTime: $uptime"

chosen="$(echo -e "$options" | $rofi_command -dmenu)" # -selected-row 2)"
  lines: 8;
case $chosen in
    $shutdown)
			systemctl poweroff
        ;;
    $reboot)
			systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
			mpc -q pause
			amixer set Master mute
			systemctl suspend
        ;;
    $logout)
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
        ;;
esac
