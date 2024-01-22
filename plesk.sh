#!/bin/bash

wget http://installer.plesk.com/plesk-installer -O - | sh /dev/stdin --source http://installer.plesk.com/ --target /tmp/plesk-installation --select-product-id plesk --select-release-latest --installation-type "Typical" --notify-email cloudpapke@gmail.com

