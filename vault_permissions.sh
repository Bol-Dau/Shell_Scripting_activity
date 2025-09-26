#!/bin/bash

if [ ! -d "secure_vault" ]; then 
	echo "'secure_vault' does not exist"
	exit 1
fi

cd secure_vault

update_permission() {
	file=$allfiles
	default_perm=$defperm

	if [ ! -e "$file" ]; then
		echo "Warning: $file not found"
		return
	fi

	echo "current permission for $file:"
	ls -l "$file"

	echo -n "Do you want to update permissions for $file ? (y/n):"
	read answer

	if [ "$answer" = "y"]; then
		echo -n "Enter new permission(600,700,644), or press Enter for default [$default_perm]:"
read perm

if [ -z "$perm"]; then 
	perm=$default_perm
fi

chmod "$perm" "$file"
echo "$file permission changed to $perm"
else
	echo "no changes made to $file"
	fi
}

update_permission "keys.txt" 600
update_permission "secrets.txt" 640
update_permission "logs.txt" 644

echo
echo "final file permissions:"
ls -l keys.txt secrets.txt logs.txt

