#!/usr/bin/env bash
set -ex

# Copy the configuration into HA container
while [ ! -d /opt/homeassistant/config/.storage ]
do
  sleep 1
done
cp -r config/. /opt/homeassistant/config/.

# Add HACS addon
if [ ! -d /opt/homeassistant/config/custom_components/hacs ]
then
  (cd /opt/homeassistant/config && wget -O - https://get.hacs.xyz | bash -)
fi

for i in $(docker ps | awk 'NR>1 {print $(NF)}')
do
  [ "homeassistant" = "$i" ] && docker restart "$i"
done


sleep 240
