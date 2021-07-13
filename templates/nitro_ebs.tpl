apt install -y linux-aws
file -s /dev/nvme0n1
mkdir /data
chown -R ubuntu:ubuntu /data
mkfs -t xfs /dev/nvme0n1
mount /dev/nvme0n1 /data