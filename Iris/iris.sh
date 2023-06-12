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

EXECUTE=iris
CHAIN_ID=irishub-1
SYSTEM_FOLDER=.iris
PROJECT_FOLDER=irishub
VERSION=v2.0.0
REPO=https://github.com/irisnet/irishub
GENESIS_FILE=https://raw.githubusercontent.com/irisnet/mainnet/master/config/genesis.json
ADDRBOOK=
PORT=26
DENOM=iris
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="fdc0406afdd3acc63f74f5439e09104f663a7c1f@44.241.177.178:26656,090bcbe5302e6104821a96c4899912870db04cb9@52.11.128.123:26656,83b3f989f3ce089afdf733f8aa06e792d7e00c08@3.34.6.30:26656,9cd1fe0109d347d49976a7353f8adcd308211f08@irisapi.terminet.io:26656,87f18756b93d835c59fe5ce2a8da51858837eb5b@54.180.15.28:26656,90e48220190b16cad95145b6213d512d703e5617@138.197.158.189:26656,7fad2da10c41b0c1e3c2ce6e708f7fa817b5e19d@135.181.56.26:46656,ebfb43ca1b592b5f8a1faf3e2aa1a34e8e1099cc@iris01.dokia.cloud:26656,a17d7923293203c64ba75723db4d5f28e642f469@seed-2.mainnet.irisnet.org:26656,fbaf634a899c7aab3c159ce1a345122bbeca3717@209.133.200.154:26656,92fadc989ed29aee0d46afce3226f8565d1f36cb@144.91.116.17:46656,895d5a5009d042108783a6aeb0991c5186a46617@144.76.96.47:26656,40821d0ade83d582b29d748f37ecf7bef0a823d0@66.42.116.195:26656,f4af63df2f5c63428be776e56ffc2899fa47afdf@47.101.160.78:26656,08e2f9453541b104df84efa68ab2f0d242eb829b@176.9.47.69:26656,db3dacf404840e067b2f59e304cb2b6662ec0cea@173.212.212.252:26656,87525da8c830da2c3a861638a77f601278efd353@185.181.103.142:26656,4ac6200974d3fd80a8e49d145a2c254ed37a9b9a@159.69.106.156:26656,4e02a4b4f4350ea2b770cd03dc41fedcadb13176@159.69.55.206:26656,5d659b3edde90344489210f5be90c0682b54b997@45.32.72.122:16656,63f5646b5f9ce927241383a091b60f797796588f@143.110.240.198:26656,84cc32adca3986b35953886ad075431d318a98b5@52.214.130.28:46656,5387e8f13cee43b47526d2d6a9d8ee65b14e4b8f@161.97.187.139:26656"
SEEDS=

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

echo "5 installation_progress"

# Updates
sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop net-tools lsof -y < "/dev/null" && sudo apt-get update -y && sudo apt-get install wget liblz4-tool aria2 -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

echo "35 installation_progress"

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "55 installation_progress"

sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make install
sleep 1


$EXECUTE init $MONIKER --chain-id $CHAIN_ID

$EXECUTE tendermint unsafe-reset-all


# Download genesis and config.toml
CONFIG_FILE=https://raw.githubusercontent.com/irisnet/mainnet/master/config/config.toml
curl -o $HOME/$SYSTEM_FOLDER/config/config.toml $CONFIG_FILE
curl -Ls $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json

# Set peers
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml

echo "80 installation_progress"

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


#state sync
SNAPSHOT=https://storage.googleapis.com/irishub-1/irishub-data-v2.0.0.tgz
curl -L $SNAPSHOT | tar -Ilz4 -xf - -C $HOME/$SYSTEM_FOLDER

echo "90 installation_progress"

sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile

