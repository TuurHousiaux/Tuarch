#!/bin/bash

################################################################################
# Author: Tuur Housiaux
# Date: 2024-04-21
# Description: Script to automate the installation of Arch Linux.
################################################################################


# Function to display menu
display_menu() {
    local keymaps=($(ls /usr/share/kbd/keymaps/**/*.map.gz | awk -F '/' '{print $NF}' | sort))
    local idx=1
    for keymap in "${keymaps[@]}"; do
        echo "$idx) $keymap"
        ((idx++))
    done
}

# Function to set keyboard layout
set_keyboard_layout() {
    local keymaps=($(ls /usr/share/kbd/keymaps/**/*.map.gz | sort))
    local dialog_cmd=(dialog --clear --title "Select Keyboard Layout" --menu "Use arrow keys to navigate, spacebar to select." 0 0 0)
    for keymap in "${keymaps[@]}"; do
        dialog_cmd+=("$keymap" "")
    done
    local choice
    choice=$("${dialog_cmd[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        local selected_keymap="$choice"
        loadkeys "$selected_keymap"
        echo "Keyboard layout set to: $selected_keymap"
    else
        echo "No layout selected. Exiting."
        exit 1
    fi
}

# Display menu and set keyboard layout
set_keyboard_layout
