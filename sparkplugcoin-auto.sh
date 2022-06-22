#!/bin/bash
wget "https://github.com/SparksChain/sparkplug-linux-wallet/raw/main/sparkplugcoin-qt-linux.tar.gz" -O sparkplugcoin-qt-linux.tar.gz

mkdir $HOME/Desktop/SPARKPLUGCOIN

tar -xzvf sparkplugcoin-qt-linux.tar.gz --directory $HOME/Desktop/SPARKPLUGCOIN

mkdir $HOME/.sparkplugcoin

cat << EOF > $HOME/.sparkplugcoin/sparkplugcoin.conf
rpcuser=rpc_sparkplugcoin
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node1.sparkschain.network
EOF

cat << EOF > $HOME/Desktop/SPARKPLUGCOIN/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./sparkplugcoin-qt
EOF

chmod +x $HOME/Desktop/SPARKPLUGCOIN/start_wallet.sh

cat << EOF > $HOME/Desktop/SPARKPLUGCOIN/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
echo Press [CTRL+C] to stop mining.
while :
do
./sparkplugcoin-cli generatetoaddress 1 \$(./sparkplugcoin-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/SPARKPLUGCOIN/mine.sh

exec $HOME/Desktop/SPARKPLUGCOIN/sparkplugcoin-qt &

sleep 15

cd $HOME/Desktop/SPARKPLUGCOIN/

clear

exec $HOME/Desktop/SPARKPLUGCOIN/mine.sh
