mkfs.ext4 -F /dev/sdc
mkdir -p /data
mount /dev/sdc /data
chmod a+w /data