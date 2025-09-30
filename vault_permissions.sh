#!/bin/bash

# Check if secure_vault exists
if [ ! -d ~/secure_vault/ ]; then
    echo "'secure_vault' does not exist"
    exit 1
fi

cd ~/secure_vault

# Function to update permission
update_permission() {
    file=$1
    default_perm=$2
    echo -e "---Processing File: $file ---\n"
    if [ ! -e "$file" ]; then
        echo "Warning: $file not found"
        return
    fi

    echo "Current permission for $file:"
    ls -l "$file"

    echo -n "Do you want to update permissions for $file? (y/n): "
    read answer

    if [ "$answer" = "y" ]; then
        echo -n "Enter new permission (600, 700, 644), or press Enter for default [$default_perm]: "
        read perm

        if [ -z "$perm" ]; then
            echo "Applying default permissions: $default_perm"
            perm=$default_perm
        fi
    elif [ "$answer" = "n" ]; then
        echo -e "No changes  made to $file\n"
        return
    elif [ -z "$answer" ]; then
        perm=$default_perm
        echo "Applying default permission: $default_per"
    else
        echo -e "Invalid input. No changes made to $file\n"
        return
    fi
    if [ -n "$perm" ]; then 
        chmod "$perm" "$file"
        echo -e "$file permission changed to $perm\n"
    else
        echo -e "No changes made to $file\n"
    fi
}

# Call function for each file
update_permission "keys.txt" 600
update_permission "secrets.txt" 640
update_permission "logs.txt" 644

# Show final permissions
echo
echo "Final file permissions:"
ls -l keys.txt secrets.txt logs.txt 

