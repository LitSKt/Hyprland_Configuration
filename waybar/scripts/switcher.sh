#!/bin/bash

directory=/home/LK/Pictures/Wallpapers

#check exist
if [ ! -d "$directory" ]; then
	notify-send -u critical "Failed!" "no such directory found"
fi

#check empty
if [ -z "$(ls -A $directory)" ]; then
	notify-send -u critical "Failed!" "no wallpaper to switch"
fi

#get wallpapers
files=()
while IFS= read -r -d '' file; do
	files+=("$file")
done< <(find "$directory" -type f -print0)

#get the number of wallpapers
num_files="${#files[@]}"

#get current wallpaper
cur_file=$(<"/home/LK/.cache/swww/eDP-2")

#change wallpaper use swww
for ((i=0; i<num_files; i++)); do
	if [ "${files[$i]}" == "$cur_file" ]; then
		if ((i == num_files-1)); then
			swww img "${files[0]}" --transition-fps 80 --transition-type grow --transition-pos top-right --transition-duration 1.3 --transition-bezier 0.43,1.19,1,0.4
		else
			swww img "${files[i+1]}" --transition-fps 80 --transition-type grow --transition-pos top-right --transition-duration 1.3 --transition-bezier 0.43,1.19,1,0.4
		fi
	fi
done
