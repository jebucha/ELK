#!/bin/bash

# ELK + Filebeat download/install/configure script for Debian based systems

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#               MUST BE RUN AS ROOT
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# download/install/configure ELK + filebeat

# download installers
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-amd64.deb
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.2-amd64.deb
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.10.2-amd64.deb
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.10.2-amd64.deb


# download basic config files
