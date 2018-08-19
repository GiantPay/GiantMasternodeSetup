#!/bin/bash

echo -e "\n\nupdate giantd ...\n\n"
cd /root/giant
wget https://github.com/GiantPay/GiantCore/releases/download/1.2.0.0/giant-1.2.0.0-linux64.zip
chmod -R 755 /root/giant-1.2.0.0-linux64.zip
unzip -o giant-1.2.0.0-linux64.zip
sleep 5
rm /root/giant/giant-qt
rm /root/giant/giant-tx
rm /root/giant/giant-1.2.0.0-linux64.zip

echo "staking=0" >> /root/.giant/giant.conf

echo -e "\n\nlaunch giantd ...\n\n"
./giant-cli stop
./giantd -daemon -reindex

echo "GIANT Masternode updated"

