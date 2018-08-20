#!/bin/bash

echo -e "\n\nupdate giantd ...\n\n"
cd /root/giant
./giant-cli stop
sleep 10

wget https://github.com/GiantPay/GiantCore/releases/download/1.2.1.0/giant-1.2.1.0-linux64.zip
chmod -R 755 /root/giant/giant-1.2.1.0-linux64.zip
unzip -o giant-1.2.1.0-linux64.zip
sleep 5
rm /root/giant/giant-qt
rm /root/giant/giant-tx
rm /root/giant/giant-1.2.1.0-linux64.zip

echo "staking=0" >> /root/.giant/giant.conf

echo -e "\n\nlaunch giantd ...\n\n"
./giantd -daemon -reindex

echo "GIANT Masternode updated"

