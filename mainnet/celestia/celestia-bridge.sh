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
BRIDGE_VERSION=v0.12.1

# Export variables
echo "export BRIDGE_REPO=$BRIDGE_REPO" >> ~/.bash_profile
echo "export BRIDGE_PROJECT_FOLDER=$BRIDGE_PROJECT_FOLDER" >> ~/.bash_profile
echo "export BRIDGE_VERSION=$BRIDGE_VERSION" >> ~/.bash_profile

source $HOME/.bash_profile

# Download and build binaries
cd $HOME
rm -rf $BRIDGE_PROJECT_FOLDER
git clone $BRIDGE_REPO
cd $BRIDGE_PROJECT_FOLDER
git checkout $BRIDGE_VERSION
make build

# Move binaries to /usr/local/bin
sudo mv build/celestia /usr/local/bin
make cel-key
sudo mv cel-key /usr/local/bin

# Add wallet
cel-key add bridge-wallet --node.type bridge --p2p.network celestia

# Init bridge node
celestia bridge init \
  --keyring.accname bridge-wallet \
  --core.ip http://localhost \
  --core.rpc.port 26657 \
  --core.grpc.port 9090 \
  --p2p.network celestia \
  --rpc.port 26658 \
  --gateway.port 26659

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
--p2p.network celestia \\
--rpc.port 26658 \\
--gateway.port 26659 \\
--metrics.tls=true \\
--metrics \\
--metrics.endpoint otel.celestia.observer 
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

# Get Bridge Node ID
AUTH_TOKEN=$(celestia bridge auth admin --p2p.network celestia)
echo "export AUTH_TOKEN=$AUTH_TOKEN" >> ~/.bash_profile
source $HOME/.bash_profile

curl -s -X POST -H "Authorization: Bearer $AUTH_TOKEN" -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' http://localhost:26658 | jq -r .result.ID

# Get Bridge Node Key
cel-key show bridge-wallet --node.type bridge --p2p.network celestia -a | tail -1

# Get Bridge Node Balance
celestia-appd q bank balances $(cel-key show bridge-wallet --node.type bridge --p2p.network celestia -a | tail -1)