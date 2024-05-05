#!/usr/bin/python
import os
import sys
import random

parameters = sys.argv
if len(parameters) == 1:
    print("None")
    sys.exit()
path = parameters[1]
wfiles = []


def list_files(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".png") or file.endswith(".jpg"): 
                wfiles.append(os.path.join(root, file))


list_files(path)
walpaper = random.choice(wfiles)
hyperpaper_script = f"preload = {walpaper}\nwallpaper = ,{walpaper}"
os.system("killall hyprpaper")
os.system("cp ~/dotfiles/.config/hypr/hyprpaper.conf ~/dotfiles/.config/hypr/hyprpaper.conf.back")
with open("/home/subhranil/dotfiles/.config/hypr/hyprpaper.conf", "w") as config:
    config.write(hyperpaper_script)
os.system(f"wal -q -s -i {walpaper}")
os.system("hyprpaper &")
os.system("killall waybar")
os.system("waybar &")

print(hyperpaper_script)
