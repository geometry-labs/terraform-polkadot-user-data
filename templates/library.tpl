for NETWORK in $(cat /home/ubuntu/deployed_networks); do
  systemctl stop $${NETWORK}
done
mkdir -p /data/polkadot
chmod a+rw /data/polkadot
chown polkadot:polkadot /data/polkadot
if [[ -d /home/polkadot/.local/share/polkadot/chains ]]
then
  mv /home/polkadot/.local/share/polkadot/ /data/
else
  mkdir -p /home/polkadot/.local/share/
fi
ln -s /data/polkadot /home/polkadot/.local/share/