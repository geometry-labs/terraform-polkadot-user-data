data "template_file" "envoy" {
  template = <<-EOT
    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

    for NETWORK in $(cat /home/ubuntu/deployed_networks); do
      echo "Templating Consul service files..."

      jinja2 -D instance_id=$INSTANCE_ID /etc/consul/consul.d/service_$${NETWORK}_json.json -o /etc/consul/consul.d/service_$${NETWORK}_json.json
      jinja2 -D instance_id=$INSTANCE_ID /etc/consul/consul.d/service_$${NETWORK}_ws.json -o /etc/consul/consul.d/service_$${NETWORK}_ws.json
      echo "Templating Systemd unit files..."
      jinja2 -D instance_id=$INSTANCE_ID /etc/systemd/system/service_$${NETWORK}_json.service -o /etc/systemd/system/service_$${NETWORK}_json.service
      jinja2 -D instance_id=$INSTANCE_ID /etc/systemd/system/service_$${NETWORK}_ws.service -o /etc/systemd/system/service_$${NETWORK}_ws.service
      echo "Reloading services..."
      systemctl daemon-reload
      systemctl restart service_$${NETWORK}_json
      systemctl restart service_$${NETWORK}_ws
      echo "Refreshing certificates..."
      /etc/consul/refresh_certs_$${NETWORK}.sh
    done

    echo "Envoy startup configuration complete!"
  EOT
}
