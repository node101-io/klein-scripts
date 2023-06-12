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
PROJECT=akash
EXECUTE=akash
CHAIN_ID=akashnet-2
SYSTEM_FOLDER=.akash
PROJECT_FOLDER=akash
VERSION=v0.22.7
REPO=https://github.com/ovrclk/akash.git
GENESIS_FILE=https://snapshots.polkachu.com/genesis/akash/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/addrbook/akash/addrbook.json
PORT=26
DENOM=uakt
GO_VERSION="1.19.9"
PEERS="8330754deb49daad39246c147f4d700b8c10d5ad@62.131.218.3:26656,d2247f7b919f0781c90ee61958d7044665a22d38@134.65.193.200:26656,a89ded27c2323388fc0f12e7a08f17424b2b7a45@135.181.142.60:15607,13e17b356b5e97ce754c94aeb9c74e846d018bdb@85.237.193.106:26656,2dcc04f0cc0ee3211bb5daecaf19e9217cd0fc00@184.105.162.170:26656,f9073ba85d59efcb4cc4ffebd5c1ba981350a717@142.54.191.218:26656,8ff3c0fdb2ebccd01eec9e3393d62fff19e02b88@52.18.59.179:26656,c58852a0c6ee1d1a68b76e5a54a9dbce895065d9@162.55.245.149:2140,dda1f59957f767e20b0fc64b1c915b4799fc0cc5@159.223.201.93:26656,c1474d697ca6d9acb19522c2ef23b9e59aac8081@68.142.182.44:26656,1e8aaf3654887a05caeb0c1f73ce39e859e2f0c9@159.223.201.86:26656,ba4ea7c936a3321bb4c65c057f7d5792b5011a25@103.180.28.208:26656,5e37aefd2a0b9d036b1609a45d6487606da0204b@169.197.141.91:26656,f31426d9fb39c2d97653722a34b4c72db71904c2@93.115.25.106:29656,7d0bc80e34d650d76e0b537c38c216bb86f37f7e@91.218.58.12:26656,6adc00bef235246c90757547d5f0703d6a548460@178.128.82.28:26656,091c621fa7cd3845f9ec568f1c631f3da406479d@98.45.205.103:26656,a23bf53f91380d13a71f4e7d910583332d9d2c0d@135.181.132.190:26656,5620bdffa93978d7258dadc13525317ede2b1e6c@174.83.6.129:26656,19235298c5bd9fe93aa0472d6b9b1006ebd33000@45.9.61.162:36656,47f7b7a021497ad7a338ea041f19a1a11ae06795@38.75.136.93:26656,5ee521ee9434dc5686cf43fe9f560adbc606fb7a@162.55.0.195:26656,8d10dbe1543e41a43f5301fc796326a79cf0b840@208.97.227.20:26656,bd2525f1a86af8b1a3798c04387f47f0c0627d24@159.223.201.38:26656,0a974e435d82fab46b3b69dfe83554d37436ff62@65.108.41.123:26654,7dfe0a2edc2a5a7bb7f6c476c3a2f275004b3b59@185.213.26.158:26656,e5a3deca200af80c7f90e9627a20d29f60936f0b@85.10.197.58:12856,9aa4c9097c818871e45aaca4118a9fe5e86c60e2@135.181.113.227:1506,4e24ed44c9bcc5ca1bbb5ddab28526e99709954b@86.32.71.164:26656,37201c92625df2814a55129f73f10ab6aa2edc35@95.214.53.215:26696,c70dbf85ceab07200b01aecd3e5c9833cd77420b@49.51.247.207:26656,b212d5740b2e11e54f56b072dc13b6134650cfb5@169.155.169.14:26656,72d8868704de83da861fbaf0d63123d4208d2bb8@65.108.6.185:26656,5c7644833f9c2cac09f05deba75e72038f18811d@89.149.218.66:26656,601462e3538bad99a06013bc2e30cfddcf4cded7@193.70.45.106:12856,e2c5c0eb62dcdbaf54535265c343ca0805596181@69.50.93.77:26656,02b5a74f0cc909045efe170da3cc5706de2c0be5@88.208.243.62:26656,89b5c363babe7c4983c3ef06c3c9ed1e39ec4246@51.79.176.202:56656,2ecb6e24df48ee037234222c67ef963daa58bcfc@65.108.102.99:29656,082fdd81d2b4a22ef1e82a5c015c97fbc351510d@86.111.48.108:26656,bebfd6597ea63cd8f675099b1fec7ef68adaf98b@135.181.138.113:26656,30b8008d4ea5069a8724a0aa73833493efa88e67@142.44.137.180:26656,6653c9097a8040c6b6819bcdb8ad94e514981968@75.100.38.68:26656,30da0ee2c35abce21e6160e43f03ece0f18cdfe7@144.76.63.67:26219,42f173cf91e2ed30a9ad2526a61c1bb8a5f94448@89.149.218.76:26656,89757803f40da51678451735445ad40d5b15e059@169.155.44.92:26656,491f88deeca991c2f898d7d4f3d69bf27b93d172@167.235.1.216:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:12856"

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

echo "30 installation_progress"

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "60 installation_progress"

sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make build
make install
sleep 1


$EXECUTE init $MONIKER --chain-id $CHAIN_ID


# Set peers and seeds
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json

echo "85 installation_progress"

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml


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




#Snapshot sync
wget -q -O - https://polkachu.com/tendermint_snapshots/${PROJECT} > webpage.html
SNAPSHOT=$(grep -o "https://snapshots.polkachu.com/snapshots/${PROJECT}/${PROJECT}_[0-9]*.tar.lz4" webpage.html | head -n 1)
cp $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup
rm -rf $HOME/$SYSTEM_FOLDER/data/*
mv $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json
curl -L $SNAPSHOT | tar -I lz4 -xf - -C $HOME/$SYSTEM_FOLDER



sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile
