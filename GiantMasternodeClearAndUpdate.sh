#!/bin/bash

GIANT_DATADIR=/root/.giant
GIANT_DATADIR_BACKUP=/root/.giant.BACKUP
GIANT_PATH=/root/giant

echo -e "\n\nupdate giantd ...\n\n"
cd $GIANT_PATH
./giant-cli stop
sleep 10

if [ -d "$GIANT_DATADIR" ]; then
  echo -e "\n\nclear giant directory ...\n\n"
  mv -f $GIANT_DATADIR $GIANT_DATADIR_BACKUP  
  mkdir -p $GIANT_DATADIR

  cp $GIANT_DATADIR_BACKUP/giant.conf $GIANT_DATADIR/giant.conf
  cp $GIANT_DATADIR_BACKUP/masternode.conf $GIANT_DATADIR/masternode.conf
  cp $GIANT_DATADIR_BACKUP/wallet.dat $GIANT_DATADIR/wallet.dat
fi

wget https://github.com/GiantPay/GiantCore/releases/download/1.4.0.0/giant-1.4.0-x86_64-linux-gnu.tar.gz
chmod -R 755 /root/giant/giant-1.4.0-x86_64-linux-gnu.tar.gz
tar -xzf giant-1.4.0-x86_64-linux-gnu.tar.gz
sleep 5
rm $GIANT_PATH/giant-qt
rm $GIANT_PATH/giant-tx
cp $GIANT_PATH/giant-1.4.0/bin/giantd $GIANT_PATH
cp $GIANT_PATH/giant-1.4.0/bin/giant-cli $GIANT_PATH
rm $GIANT_PATH/giant-1.4.0-x86_64-linux-gnu.tar.gz

echo -e "\n\nlaunch giantd ...\n\n"
./giantd -daemon -reindex

echo "GIANT Masternode updated"
