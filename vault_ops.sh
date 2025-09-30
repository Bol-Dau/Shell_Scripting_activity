#!/bin/bash


vault_dir="/home/secure_vault"
secrets_file="$vault_dir/secrets.txt"
logs_file="$vault_dir/logs.txt"
keys_file="$vault_dir/keys.txt"

# Check vault exists

if [ ! -d "$vault_dir" ]; then
  echo "❌ Error: vault not found at $vault_dir"
  echo "Run ./vault_setup.sh first."
  exit 1
fi


# Main menu loop

while true; do
  echo
  echo "======================="
  echo "   Vault Operations"
  echo "======================="
  echo "1) Add Secret"
  echo "2) Update Secret"
  echo "3) Add Log Entry"
  echo "4) Access Keys"
  echo "5) Exit"
  echo "======================="
  read -rp "Choose an option [1-5]: " choice

  case "$choice" in
    1)
      # Add Secret
      read -rp "Enter new secret: " secret
      if [ -n "$secret" ]; then
        echo "$secret" >> "$secrets_file"
        echo " Secret added."
      else
        echo "️ Secret cannot be empty."
      fi
      ;;

    2)
      # Update Secret
      read -rp "Enter text to replace: " old
      read -rp "Enter new text: " new

      if grep -q "$old" "$secrets_file"; then
        sed -i "s/$old/$new/g" "$secrets_file"
        echo " Secret updated."
      else
        echo " No match found."
      fi
      ;;


    3)
      # Add Log Entry
      read -rp "Enter log message: " log
      timestamp=$(date +"%Y-%m-%d %H:%M:%S")
      echo "[$timestamp] $log" >> "$logs_file"
      echo " Log entry added."
      ;;

    4)
      # Access Keys (always denied)
      echo "ACCESS DENIED "
      ;;

    5)
      # Exit
      echo " Exiting Vault Operations."
      break
      ;;

    *)
      echo " Invalid option, please choose 1-5."
      ;;
  esac
done
