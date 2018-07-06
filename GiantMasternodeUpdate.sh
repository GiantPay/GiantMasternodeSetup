#!/bin/bash

echo -e "\n\nsetup giantd ...\n\n"
cd /root/giant
wget https://github.com/GiantPay/GiantCore/releases/download/1.1.0.3/giant-1.1.0.3-linux64.zip
chmod -R 755 /root/giant-1.1.0.3-linux64.zip
unzip -o giant-1.1.0.3-linux64.zip
sleep 5
rm /root/giant/giant-qt
rm /root/giant/giant-tx
rm /root/giant/giant-1.1.0.3-linux64.zip

echo -e "\n\nlaunch giantd ...\n\n"
./giant-cli stop
./giantd -daemon

echo "GIANT Masternode updated"

