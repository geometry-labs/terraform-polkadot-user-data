INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

for NETWORK in $(cat /home/ubuntu/deployed_networks); do
echo "Templating Consul service files..."
jinja2 -D instance_id=$INSTANCE_ID /etc/consul/consul.d/service_$${NETWORK}_json.json -o /etc/consul/consul.d/service_$${NETWORK}_json_templated.json
mv /etc/consul/consul.d/service_$${NETWORK}_json_templated.json /etc/consul/consul.d/service_$${NETWORK}_json.json
jinja2 -D instance_id=$INSTANCE_ID /etc/consul/consul.d/service_$${NETWORK}_ws.json -o /etc/consul/consul.d/service_$${NETWORK}_ws_templated.json
mv /etc/consul/consul.d/service_$${NETWORK}_ws_templated.json /etc/consul/consul.d/service_$${NETWORK}_ws.json

echo "Templating Systemd unit files..."
jinja2 -D instance_id=$INSTANCE_ID /etc/systemd/system/service_$${NETWORK}_json.service -o /etc/systemd/system/service_$${NETWORK}_json_templated.service
mv /etc/systemd/system/service_$${NETWORK}_json_templated.service /etc/systemd/system/service_$${NETWORK}_json.service
jinja2 -D instance_id=$INSTANCE_ID /etc/systemd/system/service_$${NETWORK}_ws.service -o /etc/systemd/system/service_$${NETWORK}_ws_templated.service
mv /etc/systemd/system/service_$${NETWORK}_ws_templated.service /etc/systemd/system/service_$${NETWORK}_ws.service
echo "Refreshing certificates..."
/etc/consul/refresh_certs_$${NETWORK}.sh

echo "Reloading services..."
systemctl daemon-reload
systemctl restart service_$${NETWORK}_json
systemctl restart service_$${NETWORK}_ws

done

echo "Restarting Consul..."
systemctl restart consul

echo "Envoy startup configuration complete!"