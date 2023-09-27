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

# Download and build binaries
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

# Init bridge node
celestia bridge init \
  --keyring.accname bridge-wallet \
  --core.ip http://localhost \
  --core.rpc.port 12057 \
  --core.grpc.port 12090 \
  --p2p.network mocha \
  --rpc.port 12058 \
  --gateway.port 12059

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
--core.rpc.port 12057 \\
--core.grpc.port 12090 \\
--p2p.network mocha \\
--rpc.port 12058 \\
--gateway.port 12059 \\
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
AUTH_TOKEN=$(celestia bridge auth admin --p2p.network mocha)
curl -s -X POST -H "Authorization: Bearer $AUTH_TOKEN" -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' http://localhost:12058 | jq -r .result.ID

# Bridge node key
cel-key show bridge-wallet --node.type bridge --p2p.network mocha -a | tail -1

# Bridge node balance
celestia-appd q bank balances $(cel-key show bridge-wallet --node.type bridge --p2p.network mocha -a | tail -1)
