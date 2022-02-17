mdadm --create --verbose /dev/md0 --level=0 --name=data --raid-devices=2 /dev/nvme1n1 /dev/nvme2n1
mkdir -p /data
chown -R ubuntu:ubuntu /data
mkfs -t xfs -L data /dev/md0
mount LABEL=data /data