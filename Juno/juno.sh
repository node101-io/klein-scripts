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

EXECUTE=junod
CHAIN_ID=juno-1
SYSTEM_FOLDER=.juno
PROJECT_FOLDER=juno
VERSION=v15.0.0
REPO=https://github.com/CosmosContracts/juno.git
GENESIS_FILE=https://snapshots.polkachu.com/genesis/juno/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/addrbook/juno/addrbook.json
PORT=26
DENOM=ujuno
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="babc3f3f7804933265ec9c40ad94f4da8e9e0017@seed.rhinostake.com:12656,90b09362d9ce3845096c4938eea0dba682b0ad2c@juno-seed-new.blockpane.com:26656,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:12656,20e1000e88125698264454a884812746c2eb4807@seeds.lavenderfive.com:12656,ea67180befe4d9ca71142d21ada8ff58cc08f71c@seeds.goldenratiostaking.net:1627,e1b058e5cfa2b836ddaa496b10911da62dcf182e@juno-seed-1.allnodes.me:26656,e726816f42831689eab9378d5d577f1d06d25716@juno-seed-2.allnodes.me:26656,ebc272824924ea1a27ea3183dd0b9ba713494f83@juno-mainnet-seed.autostake.com:27136,70fcee92283edc02340289b2a74e4ab1a0203848@seed-juno.freshstaking.com:39656,47d942718533d36823e16b9502c035ca9f318ef4@seeds.whispernode.com:12656,509f6dbae3133a9df177edea051b31e1210b117e@seed-juno-01.stakeflow.io:2307"
SEEDS="7f593757c0cde8972ce929381d8ac8e446837811@178.18.255.244:26656,ebc272824924ea1a27ea3183dd0b9ba713494f83@juno-mainnet-peer.autostake.com:27136,70fcee92283edc02340289b2a74e4ab1a0203848@seed-juno.freshstaking.com:39656,3ee2034cf0180e4d50f7b3ed952472add3316faf@juno.peer.stavr.tech:1066,509f6dbae3133a9df177edea051b31e1210b117e@peer-juno-01.stakeflow.io:2307"

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


# Go installation
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
make build
make install
sleep 1

$EXECUTE config chain-id $CHAIN_ID
$EXECUTE config keyring-backend test
$EXECUTE config node tcp://localhost:15557
$EXECUTE init $MONIKER --chain-id $CHAIN_ID


# Set peers and seeds
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json


# Set Config Pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$SYSTEM_FOLDER/config/app.toml


# Set minimum gas price
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.075$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml


# Creating your systemd service
sudo tee <<EOF >/dev/null /etc/systemd/system/$EXECUTE.service
[Unit]
Description=$EXECUTE
After=network-online.target

[Service]
User=$USER
ExecStart=$(which $EXECUTE) start --home $HOME/$SYSTEM_FOLDER
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sleep 3 

#fast sync with snapshot
SNAPSHOT=https://snapshots.polkachu.com/snapshots/juno/juno_8643061.tar.lz4
cp $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup
rm -rf $HOME/$SYSTEM_FOLDER/data/*
mv $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json
curl -L $SNAPSHOT | tar -Ilz4 -xf - -C $HOME/$SYSTEM_FOLDER


sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE


echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile

