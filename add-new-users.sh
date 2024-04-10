#!/bin/bash

# Set default value for filename
PASSWORD="MySuperSecurePassword"
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

# Loop through each username in the specified file
while IFS= read -r username; do
    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping..."
    else
        # Create the user
        sudo adduser "$username" --disabled-password --gecos ""
        echo "$username:$PASSWORD" | sudo chpasswd
        echo "User $username created."
    fi
done < "$filename"

echo "User creation process completed."
