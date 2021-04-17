#!/bin/sh
# This script updates your hosts file to its latest release along
# with your own custom hosts file, saved and controlled locally.
#
# Recommended hosts file here: https://github.com/StevenBlack/hosts

hosts_url="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
expected_checksum="0fc53777f6c3d83233555961416e610722e405e158e83aa08f0b1c8afea792d9"
custom_hosts="${XDG_CONFIG_HOME:-$HOME/.config}/hosts"
system_hosts="/etc/hosts"
backup_hosts="/etc/hosts.bak"

# Backup existing hosts file
sudo cp "$system_hosts" "$backup_hosts"

# Download and verify the hosts file
temp_hosts=$(mktemp)
wget -qO "$temp_hosts" "$hosts_url"

# Verify the downloaded file (example using sha256sum)
# echo "expected_checksum  $temp_hosts" | sha256sum -c -

downloaded_checksum=$(sha256sum "$temp_hosts" | awk '{ print $1 }')

# If verification passes, update the system hosts file
if [ "$downloaded_checksum" = "$expected_checksum" ]; then
    sudo cp "$temp_hosts" "$system_hosts"
    sudo chmod 644 "$system_hosts"
else
    echo "Downloaded hosts file verification failed!"
    rm "$temp_hosts"
    exit 1
fi

# Add custom hosts file to system hosts file
if [ -f "$custom_hosts" ]; then
    sudo tee -a "$system_hosts" <"$custom_hosts" >/dev/null
fi

# Clean up
rm "$temp_hosts"