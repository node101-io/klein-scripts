#! /bin/bash

echo -e '\e[0m'                                                              
echo -e '@@@  @@@   @@@@@@   @@@@@@@   @@@@@@@@    @@@   @@@@@@@@     @@@'
echo -e '@@@@ @@@  @@@@@@@@  @@@@@@@@  @@@@@@@@   @@@@  @@@@@@@@@@   @@@@'
echo -e '@@!@!@@@  @@!  @@@  @@!  @@@  @@!       @@@!!  @@!   @@@@  @@@!!'
echo -e '!@!!@!@!  !@!  @!@  !@!  @!@  !@!         !@!  !@!  @!@!@    !@!'
echo -e '@!@ !!@!  @!@  !@!  @!@  !@!  @!!!:!:     @!@  @!@ @! !@!    @!@'
echo -e '!@!  !!!  !@!  !!!  !@!  !!!  !!!!!::     !@!  !@!!!  !!!    !@!'
echo -e '!!:  !!!  !!:  !!!  !!:  !!!  !!:         !!:  !!:!   !!!    !!:'
echo -e ':!:  !:!  :!:  !:!  :!:  !:!  :!:         :!:  :!:    !:!    :!:'
echo -e ':::   ::   ::::::   :::::::   :::::::     :::   ::::::::     :::'
echo -e '\e[0m'

# Variables
BRIDGE_REPO=https://github.com/celestiaorg/celestia-node.git
BRIDGE_PROJECT_FOLDER=celestia-node
BRIDGE_VERSION=v0.11.0-rc12

echo "export BRIDGE_REPO=$BRIDGE_REPO" >> ~/.bash_profile
echo "export BRIDGE_PROJECT_FOLDER=$BRIDGE_PROJECT_FOLDER" >> ~/.bash_profile
echo "export BRIDGE_VERSION=$BRIDGE_VERSION" >> ~/.bash_profile

source $HOME/.bash_profile

celestia bridge unsafe-reset-store --p2p.network mocha

# Download and build binaries
cd $HOME
rm -rf $BRIDGE_PROJECT_FOLDER
git clone $BRIDGE_REPO
cd $BRIDGE_PROJECT_FOLDER
git checkout $BRIDGE_VERSION
make build
sudo mv build/celestia /usr/local/bin
make cel-key
sudo mv cel-key /usr/local/bin

# Add wallet
cel-key add bridge-wallet --node.type bridge --p2p.network mocha

celestia bridge init \
  --keyring.accname bridge-wallet \
  --core.ip http://localhost \
  --core.rpc.port 26657 \
  --core.grpc.port 9090 \
  --p2p.network mocha-4 \
  --rpc.port 20258 \
  --gateway.port 20259

# Create service
sudo tee /etc/systemd/system/celestia-bridge.service > /dev/null << EOF
[Unit]
Description=Celestia Bridge Node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which celestia) bridge start \\
--keyring.accname bridge-wallet \\
--core.ip http://localhost \\
--core.rpc.port 26657 \\
--core.grpc.port 9090 \\
--p2p.network mocha \\
--rpc.port 20258 \\
--gateway.port 20259 \\
--metrics.tls=false \\
--metrics \\
--metrics.endpoint otel.celestia.tools:4318 
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable celestia-bridge

# start bridge node
systemctl restart celestia-bridge

# Check logs
journalctl -fu celestia-bridge -o cat

# Bridge node ID
AUTH_TOKEN=$(celestia bridge auth admin --p2p.network mocha-4)
curl -s -X POST -H "Authorization: Bearer $AUTH_TOKEN" -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' http://localhost:20258 | jq -r .result.ID

# Bridge node key
cel-key show bridge-wallet --node.type bridge --p2p.network mocha-4 -a | tail -1
celestia1twt9e55l4az3qz7e7zxhvpc8pv467shq25nlz4
# Bridge node balance
celestia-appd q bank balances $(cel-key show bridge-wallet --node.type bridge --p2p.network mocha-4 -a | tail -1)


sudo systemctl stop celestia-bridge.service

cd ~/.celestia-bridge-mocha-4/

rm -rf config.toml

cd data/

rm -rf *

cd ..

celestia bridge unsafe-reset-store --p2p.network mocha-4

cd -

~/celestia-node/

celestia bridge init   --keyring.accname bridge-wallet   --core.ip http://localhost   --core.rpc.port 26657   --core.grpc.port 9090   --p2p.network mocha-4   --rpc.port 12058   --gateway.port 12059

sudo systemctl restart celestia-bridge.service

sudo journalctl -u celestia-bridge.service -f --no-hostname -o cat



mkdir ethereum
git clone https://github.com/ethereum/go-ethereum.git
cd go-ethereum

make all

make geth

./build/bin/geth