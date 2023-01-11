#!/usr/bin/env bash
set -ex

# Copy the configuration into HA container
cp_initial_config () {
  while [ ! -d /opt/homeassistant/config/.storage ]
  do
    sleep 1
  done
  cp -r config/. /opt/homeassistant/config/.
}

# Restart Home Assistant container
restart_ha () {
  for i in $(docker ps | awk 'NR>1 {print $(NF)}')
  do
    [ "homeassistant" = "$i" ] && docker restart "$i" && break
  done
}

# Install HACS addon
install_hacs () {
  if [ ! -d /opt/homeassistant/config/custom_components/hacs ]
  then
    (cd /opt/homeassistant/config && wget -O - https://get.hacs.xyz | bash -)
    restart_ha
  fi
}


cp_initial_config
install_hacs
