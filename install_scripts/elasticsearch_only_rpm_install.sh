#!/bin/bash

# Installation of Elasticsearch only dedicated master for RHEL/Cent/Rocky

# Run as root

# Download Elasticsearch
wget -nc https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.18.rpm

# Install package
rpm -ivh elasticsearch-6.8.18.rpm

# backup the yml
cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.orig


# setup elasticsearch
path="/etc/elasticsearch/"
filename="elasticsearch.yml"
strClusterNameOrig='#cluster.name: my-application'
strClusterNameNew='cluster.name: graylog'
strNodeNameOrig='#node.name: node-1'
strNodeNameNew='node.name: ${HOSTNAME}'
strHostOrig='#network.host: 192.168.0.1'
strHostNew='network.host: ["_local_","_site_"]'
strPortOrig='#http.port: 9200'
strPortNew='http.port: 9200'
strUnicastDiscoveryOrig='#discovery.zen.ping.unicast.hosts: ["host1", "host2"]'
strUnicastDiscoveryNew='discovery.zen.ping.unicast.hosts: ["192.168.1.188", "192.168.1.148"]'
strMinMasterOrig='#discovery.zen.minimum_master_nodes:'
strMinMasterNew='discovery.zen.minimum_master_nodes: 2'
echo "node.master: true" >> $path/$filename
echo "node.data: false" >> $path/$filename
echo "node.ingest: false" >> $path/$filename
sed -i "s|$strClusterNameOrig|$strClusterNameNew|g" $path/$filename
sed -i "s|$strHostOrig|$strHostNew|g" $path/$filename
sed -i "s|$strUnicastDiscoveryOrig|$strUnicastDiscoveryNew|g" $path/$filename
sed -i "s|$strMinMasterOrig|$strMinMasterNew|g" $path/$filename
sed -i "s|$strNodeNameOrig|$strNodeNameNew|g" $path/$filename
sed -i "s|$strPortOrig|$strPortNew|g" $path/$filename

# set the owner
chown -R elasticsearch:elasticsearch /etc/elasticsearch/

# enable the services
systemctl daemon-reload
systemctl enable elasticsearch.service

# start the services
systemctl start elasticsearch.service

# delay for 60 seconds to let the services come up
echo -e '60 second delay for services to start'
sleep 60
echo -e '60 second delay over'

# quick functionality test (security not yet enabled)
curl -XGET http://localhost:9200

echo 'Done'
