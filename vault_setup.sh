#!/bin/bash
vault1="/home/secure_vault"

if [ ! -d "$vault1" ]; then
mkdir -p "$vault1"
fi


echo "#welcome to keys.txt to store encryption keys" > "$vault1/keys.txt"
echo "#welcome to secrets.txt to store confidential data" > "$vault1/secrets.txt"
echo "#welcome to logs.txt to store system logs" > "$vault1/logs.txt"

echo "$vault1 was created successfully"

ls -l "$vault1"
