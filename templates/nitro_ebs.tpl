apt-get upgrade -y linux-aws
file -s /dev/nvme1n1
mkdir /data
chown -R ubuntu:ubuntu /data
mkfs -t xfs /dev/nvme1n1
mount /dev/nvme1n1 /data