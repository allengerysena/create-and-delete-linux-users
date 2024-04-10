#!/bin/bash

# Set default value for filename
filename=""

# Function to display script usage
usage() {
    echo
    echo "Error: You must specify a filename using -f option."
    echo
    echo "Usage: $0 -f filename"
    echo
    echo "Options:"
    echo "  -f  Specify the filename containing the list of usernames"
    echo
    exit 1
}

# Parse command-line options
while getopts ":f:" option; do
    case "$option" in
        f)
            filename=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

# Check if filename is empty
if [ -z "$filename" ]; then
    usage
fi

# Check if the specified file exists
if [ ! -f "$filename" ]; then
    echo "Error: $filename not found."
    exit 1
fi

# Ensure the script is run with sudo privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Loop through each username in the specified file
while IFS= read -r name; do
    # Remove user and home directory (-r)
    sudo userdel -r "$name"
    # Check if the user was successfully deleted
    if [ $? -eq 0 ]; then
        echo "User $name deleted successfully."
    else
        echo "Failed to delete user $name."
    fi
done < "$filename"

exit 0
