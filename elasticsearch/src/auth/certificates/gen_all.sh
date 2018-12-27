#!/bin/bash

chmod +x /elasticsearch/plugins/search-guard-6/tools/hash.sh
cd /elasticsearch/config/searchguard/ssl

# if env changes
if [ ! -f .ca_pwd ] || [ "$CA_PWD" != $(cat .ca_pwd) ] || [ ! -f .ts_pwd ] || [ "$TS_PWD" != $(cat .ts_pwd) ] || [ ! -f .ks_pwd ] || [ "$KS_PWD" != $(cat .ks_pwd) ]; then
 #In the gen_all.sh script we comment the init.sh and gen_root_ca.sh scripts as they remove all previous keys,
 # certificates, trustores and generate new root keys,certificates, trustores
 # https://github.com/floragunncom/search-guard-ssl/blob/master/example-pki-scripts/gen_root_ca.sh
 # https://medium.com/@ophamster/elasticsearch-with-search-guard-on-gke-239173dc4048
 # /run/auth/certificates/init.sh
 # /run/auth/certificates/gen_root_ca.sh

  /run/auth/certificates/gen_node_cert.sh
  /run/auth/certificates/gen_client_node_cert.sh elastic
  /run/auth/certificates/gen_client_node_cert.sh kibana
  /run/auth/certificates/gen_client_node_cert.sh logstash
  /run/auth/certificates/gen_client_node_cert.sh beats
  touch .ca_pwd
  echo $CA_PWD > .ca_pwd
  touch .ts_pwd
  echo $TS_PWD > .ts_pwd
  touch .ks_pwd
  echo $KS_PWD > .ks_pwd
fi