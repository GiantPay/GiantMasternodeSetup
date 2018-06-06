#!/bin/bash

echo -e "create swap ...\n\n"
sudo touch /var/swap.img
sudo chmod 600 /var/swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab

echo -e "\n\nupdate & prepare system ...\n\n"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install nano htop git -y

sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common python-software-properties libzmq5-dev libminiupnpc-dev unzip -y
sudo apt-get install libboost-all-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

echo -e "\n\nsetup giantd ...\n\n"
cd ~
wget https://github.com/GiantPay/GiantCore/releases/download/1.1.0.2/giant-1.1.0.2-linux64.zip
chmod -R 755 /root/giant-1.1.0.2-linux64.zip
unzip -o giant-1.1.0.2-linux64.zip
sleep 5
mkdir /root/giant
mkdir /root/.giant
cp /root/giantd /root/giant
cp /root/giant-cli /root/giant
sleep 5
rm /root/giantd
rm /root/giant-cli
rm /root/giant-qt
rm /root/giant-tx
rm /root/giant-1.1.0.2-linux64.zip
chmod -R 755 /root/giant
chmod -R 755 /root/.giant

echo -e "\n\nlaunch giantd ...\n\n"
sudo apt-get install -y pwgen
GEN_PASS=`pwgen -1 20 -n`
IP_ADD=`curl ipinfo.io/ip`

echo -e "rpcuser=giantuser\nrpcpassword=${GEN_PASS}\nserver=1\nlisten=1\nmaxconnections=256\ndaemon=1\nrpcallowip=127.0.0.1\nexternalip=${IP_ADD}:40444" > /root/.giant/giant.conf
cd /root/giant
./giantd
sleep 40
masternodekey=$(./giant-cli masternode genkey)
./giant-cli stop

echo -e "masternode=1\nmasternodeprivkey=$masternodekey\n\n\n" >> /root/.giant/giant.conf
echo -e "addnode=144.76.15.105:40444" >> /root/.giant/giant.conf
echo -e "addnode=94.130.187.187:40444" >> /root/.giant/giant.conf
echo -e "addnode=94.130.184.45:40444" >> /root/.giant/giant.conf
echo -e "addnode=195.201.20.27:40444" >> /root/.giant/giant.conf
echo -e "addnode=88.99.87.205:40444" >> /root/.giant/giant.conf
echo -e "addnode=88.99.87.217:40444" >> /root/.giant/giant.conf
echo -e "addnode=78.47.139.252:40444" >> /root/.giant/giant.conf
echo -e "addnode=78.47.141.178:40444" >> /root/.giant/giant.conf
echo -e "addnode=88.198.201.68:40444" >> /root/.giant/giant.conf
echo -e "addnode=88.198.201.21:40444" >> /root/.giant/giant.conf
echo -e "addnode=94.130.185.15:40444" >> /root/.giant/giant.conf
echo -e "addnode=195.201.127.214:40444" >> /root/.giant/giant.conf
echo -e "addnode=78.46.150.97:40444" >> /root/.giant/giant.conf
echo -e "addnode=95.216.137.189:40444" >> /root/.giant/giant.conf
echo -e "addnode=95.216.137.190:40444" >> /root/.giant/giant.conf
echo -e "addnode=95.216.137.191:40444" >> /root/.giant/giant.conf

./giantd -daemon
cd /root/.giant
ufw allow 40444

# output masternode key
echo -e "Masternode private key: $masternodekey"
echo -e "Welcome to the GIANT Masternode Network!"

