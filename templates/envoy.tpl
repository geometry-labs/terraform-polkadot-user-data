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

echo "Reloading services..."
systemctl daemon-reload
systemctl restart service_$${NETWORK}_json
systemctl restart service_$${NETWORK}_ws

echo "Restarting Consul..."
systemctl restart consul

echo "Ensuring Consul is running..."
systemctl start consul

while [[ "$(curl -s -o /dev/null -w ''%%{http_code}'' http://127.0.0.1:8500/v1/agent/self)" != "200" ]]; do
echo "Consul not ready yet. Waiting..."
sleep 1
done

echo "Consul is ready. Waiting 1 minute to sync services..."
sleep 60

echo "Refreshing certificates..."
/etc/consul/refresh_certs_$${NETWORK}.sh
done

echo "Envoy startup configuration complete!"