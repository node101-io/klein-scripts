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

# Updates
sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop net-tools lsof -y < "/dev/null" && sudo apt-get update -y && sudo apt-get install wget liblz4-tool aria2 -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

echo "5 installation_progress"

# Variables
ETHEREUM_DIR="ethereum"
EXECUTE="geth"
GETH_DOWNLOAD_URL="https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.13.2-dc34fe82.tar.gz"
GETH_TAR_NAME="geth-linux-amd64-1.13.2-dc34fe82.tar.gz"
GETH_DIR_NAME="geth-linux-amd64-1.13.2-dc34fe82"
PRYSM_DIR="prysm"
CONS_CLIENT="prysmd"
PRYSM_SCRIPT_URL="https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh"
PRYSM_GENESIS_URL="https://github.com/eth-clients/eth2-networks/raw/master/shared/prater/genesis.ssz"

sleep 1

echo "export ETHEREUM_DIR=${ETHEREUM_DIR}" >> $HOME/.bash_profile
echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export GETH_DOWNLOAD_URL=${GETH_DOWNLOAD_URL}" >> $HOME/.bash_profile
echo "export GETH_TAR_NAME=${GETH_TAR_NAME}" >> $HOME/.bash_profile
echo "export GETH_DIR_NAME=${GETH_DIR_NAME}" >> $HOME/.bash_profile
echo "export PRYSM_DIR=${PRYSM_DIR}" >> $HOME/.bash_profile
echo "export CONS_CLIENT=${CONS_CLIENT}" >> $HOME/.bash_profile
echo "export PRYSM_SCRIPT_URL=${PRYSM_SCRIPT_URL}" >> $HOME/.bash_profile
echo "export PRYSM_GENESIS_URL=${PRYSM_GENESIS_URL}" >> $HOME/.bash_profile
source $HOME/.bash_profile

# Ethereum installation
mkdir $ETHEREUM_DIR && cd $ETHEREUM_DIR
wget $GETH_DOWNLOAD_URL
tar -xzvf $GETH_TAR_NAME
mv $GETH_DIR_NAME/geth /usr/bin
rm -rf $GETH_DIR_NAME
geth version

# Geth systemd service
sudo tee /etc/systemd/system/geth.service > /dev/null << EOF
[Unit]
Description=Ethereum Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/bin/geth  --syncmode "snap" --http --http.vhosts "*" --http.addr 0.0.0.0 --http.api eth,net,engine,admin --authrpc.jwtsecret $HOME/prysm/jwt.hex
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable geth
sudo systemctl daemon-reload
sudo systemctl start geth

echo "40 installation_progress"

# Prysm installation
cd $HOME
mkdir $PRYSM_DIR && cd $PRYSM_DIR
curl $PRYSM_SCRIPT_URL --output prysm.sh && chmod +x prysm.sh
wget $PRYSM_GENESIS_URL
./prysm.sh beacon-chain generate-auth-secret
echo "accept" | ./prysm.sh beacon-chain --execution-endpoint=http://localhost:8551 --jwt-secret=$HOME/prysm/jwt.hex --genesis-state=./genesis.ssz

cd $HOME

# Prysm systemd service
sudo tee /etc/systemd/system/prysmd.service > /dev/null << EOF
[Unit]
Description=Ethereum Consensus Layer
After=network.target

[Service]
User=$USER
Type=simple
WorkingDirectory=$HOME/prysm
ExecStart=$HOME/prysm/prysm.sh beacon-chain --execution-endpoint=http://localhost:8551 --jwt-secret=$HOME/prysm/jwt.hex
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable prysmd
sudo systemctl daemon-reload
sudo systemctl start prysmd

echo "70 installation_progress"

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "\nCHECK OUT YOUR LOGS FOR EXECUTION CLIENT: \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK OUT YOUR LOGS FOR CONSENSUS CLIENT: \e[1m\e[32mjournalctl -fu ${CONS_CLIENT} -o cat\e[0m"
source $HOME/.bash_profile

rm -- "$0"