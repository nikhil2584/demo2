#!/bin/bash
#wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
#tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz
#sudo mv -v node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/
chown root:root /opt/nodeexporter
node_exporter --version
echo '[Unit]
Description=Prometheus exporter for machine metrics

[Service]
Restart=always
User=root
ExecStart=/opt/nodeexporter/
ExecReload=/bin/kill -HUP $MAINPID
TimeoutStopSec=20s
SendSIGKILL=no

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/node-exporter.service
sudo systemctl daemon-reload
sudo systemctl start node-exporter.service
sudo systemctl enable node-exporter.service
sudo systemctl status node-exporter.service

