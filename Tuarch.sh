#!/bin/bash

################################################################################
# Author: Tuur Housiaux
# Date: 2024-04-21
# Description: Script to automate the installation of Arch Linux.
################################################################################

# Function to display menu
display_menu() {
    echo "Select your keyboard layout:"
    local keymaps=($(ls /usr/share/kbd/keymaps/**/*.map.gz | awk -F '/' '{print $NF}' | sort))
    local idx=1
    for keymap in "${keymaps[@]}"; do
        echo "$idx) $keymap"
        ((idx++))
    done
}

# Function to set keyboard layout
set_keyboard_layout() {
    read -rp "Enter the number corresponding to your keyboard layout: " choice
    local keymaps=($(ls /usr/share/kbd/keymaps/**/*.map.gz | sort))
    if (( choice >= 1 && choice <= ${#keymaps[@]} )); then
        local selected_keymap="${keymaps[choice-1]}"
        loadkeys "$selected_keymap"
        echo "Keyboard layout set to: $selected_keymap"
    else
        echo "Invalid choice. Please enter a valid number."
        set_keyboard_layout
    fi
}

# Display menu and set keyboard layout
display_menu
set_keyboard_layout