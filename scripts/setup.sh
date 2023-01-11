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

echo "$(hostname): It is required to restart the homeassistant container for this changes take effect!"
