#!/usr/bin/env ash
set -ex

if ! grep bash /etc/shells
then
  apk update
  apk upgrade
  apk add --no-cache bash
fi
cat /etc/shells
