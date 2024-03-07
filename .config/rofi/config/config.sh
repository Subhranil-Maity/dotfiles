#!/usr/bin/env bash


# Check if directory is provided as argument, otherwise use current directory
directory="$HOME/dotfiles/.config"
bbash=".bashrc"
sstow="STOW the DotFiles"
list="$sstow\n$bbash"
# # Check if the directory exists
# if [ ! -d "$directory" ]; then
#     echo "Error: Directory '$directory' does not exist."
#     exit 1
# fi

# Iterate through each item in the directory
for item in "$directory"/*; do
    # Check if the item is a directory
    if [ -d "$item" ]; then
        # Extract and print the folder name
        folder_name=$(basename "$item")
        # echo "$folder_name"
		list="$list\n$folder_name"
    fi
done

result=$(echo -e $list | rofi -show -dmenu)
if [[ -z "$result" ]] then
		echo "OUTPUT IS Blank"
elif [[ "$result" == "$bbash" ]]; then
		kitty nvim "$HOME/$bbash"
elif [[ "$result" == "$sstow" ]]; then
		echo "bash"
else
		echo "OUTPUT IS $result"
		kitty nvim "$HOME/dotfiles/.config/$result"
fi


