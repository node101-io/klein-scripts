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

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu \
    bsdmainutils htop net-tools lsof liblz4-tool aria2 chrony

GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | grep '^go' | sed 's/^go//')
REPO=https://github.com/celestiaorg/celestia-node.git
PROJECT_FOLDER=celestia-node
DAEMON_VERSION=v0.14.0
DAEMON_NAME=celestia
DAEMON_NETWORK=mocha
DEFAULT_KEY_NAME=my_celes_key
DEFAULT_RPC_PORT=10101
NODE_TYPE=light
RPC_ENDPOINT=rpc-mocha.pops.one
CELESTIA_OTEL_URL=otel.celestia.tools:4318

echo "export GO_VERSION=${GO_VERSION}" >> ~/.bash_profile
echo "export REPO=${REPO}" >> ~/.bash_profile
echo "export PROJECT_FOLDER=${PROJECT_FOLDER}" >> ~/.bash_profile
echo "export DAEMON_VERSION=${DAEMON_VERSION}" >> ~/.bash_profile
echo "export DAEMON_NAME=${DAEMON_NAME}" >> ~/.bash_profile
echo "export DAEMON_NETWORK=${DAEMON_NETWORK}" >> ~/.bash_profile
echo "export NODE_TYPE=${NODE_TYPE}" >> ~/.bash_profile

source ~/.bash_profile

cd ~
wget "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
rm "go${GO_VERSION}.linux-amd64.tar.gz"

sleep 1

cd ~
rm -rf ${PROJECT_FOLDER}
git clone $REPO
cd ${PROJECT_FOLDER}
git checkout tags/${DAEMON_VERSION}
make build

mv build/${DAEMON_NAME} /usr/local/bin/
rm -rf build

make cel-key
mv cel-key /usr/local/bin/

cd ~

celestia ${NODE_TYPE} init --p2p.network ${DAEMON_NETWORK}

cel-key add ${DEFAULT_KEY_NAME} \
  --keyring-backend test \
  --node.type ${NODE_TYPE} \
  --p2p.network ${DAEMON_NETWORK}

sudo tee <<EOF >/dev/null /etc/systemd/system/${DAEMON_NAME}.service
[Unit]
Description=${DAEMON_NAME} ${NODE_TYPE} Node
After=network-online.target

[Service]
User=root
ExecStart=$(which ${DAEMON_NAME}) ${NODE_TYPE} start \
  --core.ip ${RPC_ENDPOINT} \
  --keyring.accname ${DEFAULT_KEY_NAME} \
  --metrics.tls=false \
  --metrics \
  --metrics.endpoint ${CELESTIA_OTEL_URL} \
  --p2p.network ${DAEMON_NETWORK} \
  --rpc.port ${DEFAULT_RPC_PORT}
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable ${DAEMON_NAME}
sudo systemctl restart ${DAEMON_NAME}

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${DAEMON_NAME} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:26657/status | jq .result.sync_info\e[0m"

source ~/.bash_profile