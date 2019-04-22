#!/bin/bash

echo -e "\n\nupdate giantd ...\n\n"
cd /root/giant
./giant-cli stop
sleep 10

wget https://github.com/GiantPay/GiantCore/releases/download/1.3.0.0/giant-1.3.0-x86_64-linux-gnu.tar.gz
chmod -R 755 /root/giant/giant-1.3.0-x86_64-linux-gnu.tar.gz
tar -xzf giant-1.3.0-x86_64-linux-gnu.tar.gz
sleep 5
rm /root/giant/giant-qt
rm /root/giant/giant-tx
cp /root/giant/giant-1.3.0/bin/giantd /root/giant
cp /root/giant/giant-1.3.0/bin/giant-cli /root/giant
rm /root/giant/giant-1.3.0-x86_64-linux-gnu.tar.gz

echo -e "\n\nlaunch giantd ...\n\n"
./giantd -daemon -reindex

echo "GIANT Masternode updated"
