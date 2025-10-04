#!/bin/bash
set -euo pipefail

COMMANDS=(
	curl
	sed
	mountpoint
	cryptsetup
)

for cmd in "${COMMANDS[@]}";
do
	if command -v "$cmd" >/dev/null 2>&1; then
	        echo "Команда '$cmd' найдена"
	else
		exit 1
	fi
done

vault_token=your_token
vault_uri=https://secrets.examle.com/v1/luks/data/debian
uuid=759cd887-cc01-4cb9-9a7e-5ed961cf03f9
mnt_path=/mnt
token=verystrongtoken


if ! mountpoint -q /mnt; then
	file=$(openssl rand -hex 100)
	curl \
	  --header "X-Vault-Token: $token" \
	  --request GET $vault_uri \
	  | sed -n 's/.*"key":"\([^"]*\)".*/\1/p' \
	  | sed 's/\\n/\n/g' > /dev/shm/$file
	cryptsetup --verbose open --key-file /dev/shm/$file /dev/sda1 crypto_data
	rm /dev/shm/$file
	mount -t btrfs -o noatime,space_cache=v2,compress=zstd:1 UUID=$uuid $mnt_path
fi

cat /etc/systemd/system/luks-decryptor.service 
[Unit]
Description=Run my script when network is online
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/luks-decryptor.sh

[Install]
WantedBy=multi-user.target


