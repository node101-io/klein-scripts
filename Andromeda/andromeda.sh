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

EXECUTE=andromedad
CHAIN_ID=galileo-3
SYSTEM_FOLDER=.andromedad
PROJECT_FOLDER=andromedad 
VERSION=galileo-3-v1.1.0-beta1
REPO=https://github.com/andromedaprotocol/andromedad.git
GENESIS_FILE=https://snapshots.kjnodes.com/andromeda-testnet/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/andromeda-testnet/addrbook.json
PORT=26
DENOM=uandr
GO_VERSION="1.19.3" 
PEERS="1ccba3e77b1e469df0518e469e4a3fbbb32f64ad@rpc.andromeda-testnet.mirror-reflection.com:31656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@andromeda-testnet.rpc.kjnodes.com:47656,c043b90a737b92b26b39c52c502d7468dc6b1481@46.0.203.78:22258,9d058b4c4eb63122dfab2278d8be1bf6bf07f9ef@65.109.86.236:26656,7ac17e470c16814be55aa02a1611b23a3fba3097@75.119.141.16:26656,c5f6021d8da08ff53e90725c0c2a77f8d65f5e03@195.201.195.40:26656,bcdd1b337504f2d3523f6d63a7de1a2641187908@154.26.130.175:26656,1d94f397352dc20be4b56e4bfd9305649cbac778@65.108.232.150:20095,749114faeb62649d94b8ed496efbdcd4a08b2e3e@136.243.93.134:20095"
SEEDS="e711b6631c3e5bb2f6c389cbc5d422912b05316b@seed.ppnv.space:37256,5cfce64114f98e29878567bdd1adbebe18670fc6@andromeda-testnet-seed.itrocket.net:443,3f472746f46493309650e5a033076689996c8881@andromeda-testnet.rpc.kjnodes.com:47659"

sleep 2

echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export CHAIN_ID=${CHAIN_ID}" >> $HOME/.bash_profile
echo "export SYSTEM_FOLDER=${SYSTEM_FOLDER}" >> $HOME/.bash_profile
echo "export PROJECT_FOLDER=${PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export VERSION=${VERSION}" >> $HOME/.bash_profile
echo "export REPO=${REPO}" >> $HOME/.bash_profile
echo "export GENESIS_FILE=${GENESIS_FILE}" >> $HOME/.bash_profile
echo "export ADDRBOOK=${ADDRBOOK}" >> $HOME/.bash_profile
echo "export PORT=${PORT}" >> $HOME/.bash_profile
echo "export DENOM=${DENOM}" >> $HOME/.bash_profile
echo "export GO_VERSION=${GO_VERSION}" >> $HOME/.bash_profile
echo "export PEERS=${PEERS}" >> $HOME/.bash_profile
echo "export SEEDS=${SEEDS}" >> $HOME/.bash_profile


source $HOME/.bash_profile

sleep 1
if [ ! $MONIKER ]; then
	read -p "ENTER MONIKER NAME: " MONIKER
	echo 'export MONIKER='$MONIKER >> $HOME/.bash_profile
fi



# Updates
sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop net-tools lsof -y < "/dev/null" && sudo apt-get update -y && sudo apt-get install wget liblz4-tool aria2 -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version


sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make install

sleep 1

$EXECUTE init $MONIKER --chain-id $CHAIN_ID


# Set peers and seeds
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml



# Set Config Pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $NODE_HOME/config/config.toml
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0001$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

# Download genesis and addrbook
wget -qO- $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json
wget -qO- $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json

$EXECUTE tendermint unsafe-reset-all --home $HOME/$SYSTEM_FOLDER --keep-addr-book

# Snapshot sync

cp $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json $HOME/.andromedad/priv_validator_state.json.backup
rm -rf $HOME/$SYSTEM_FOLDER/data

wget -qO- https://snapshots.kjnodes.com/andromeda-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/$SYSTEM_FOLDER
mv $HOME/.andromedad/priv_validator_state.json.backup $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json

# Creating your systemd service
sudo tee <<EOF >/dev/null /etc/systemd/system/$EXECUTE.service
[Unit]
Description=$EXECUTE
After=network.target

[Service]
User=$USER
ExecStart=$(which $EXECUTE) start --home $HOME/$SYSTEM_FOLDER
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile


