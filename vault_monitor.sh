#!/bin/bash
# exec sends the output to value_report.txt while tee displays the content on the terminal
exec > >(tee -a /home/secure_vault/vault_report.txt)

# Listing all the files in the long list format.
echo " "
details=$(ls -l /home/secure_vault)
echo "Here are the details of your files"
echo -e "$details\n"

# Checking if any file permissions go beyond 644
Security=$(find /home/secure_vault/ -type f -perm /133 2>/dev/null)
if [ -n "$Security" ]; then
   echo -e "SECURITY RISK DETECTED\n"
   echo "Here are the files at risk"
   echo -e "$Security\n"
else
   echo "All safe"
fi
echo
# Print the confirmation message
echo -e "Report saved to: vault_report.txt on $(date +%d/%m/%Y_%H:%M:%S)\n" >&2
exit
