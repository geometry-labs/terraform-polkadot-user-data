mkdir /data
chown -R ubuntu:ubuntu /data/
mkfs.ext4 /dev/xvdf
mount /dev/xvdf /data