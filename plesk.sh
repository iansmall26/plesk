#!/bin/bash
sudo su -
cloud-init-per once wget -O - http://installer.plesk.com/one-click-installer | sh >> installog.txt
tail -f installog.txt

