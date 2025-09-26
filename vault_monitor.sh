#!/bin/bash
# exec sends the output to value_report.txt while tee displays the content on the terminal
exec > >(tee -a /home/secure_vault/vault_report.txt)
# Listing all the files in the long list format.
details=$(ls -l /home/secure_vault)
echo "$details"

# Checking if any file permissions go beyond 644
Security=$(find /home/secure_vault/ -type f -perm /133 2>/dev/null)
if [ -n "$Security" ]; then
   echo "⚠️ SECURITY RISK DETECTED"
   echo "$Security"
else
   echo "All safe"
fi
# Print the confirmation message
echo "Report saved to: vault_report.txt at $(date +%d/%m/%Y_%H:%M:%S)" >&2
exit

