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

EXECUTE=strided
CHAIN_ID=stride-1
SYSTEM_FOLDER=.stride
PROJECT_FOLDER=stride
VERSION=v9.2.1
REPO=https://github.com/Stride-Labs/stride.git
GENESIS_FILE=https://snapshots.kjnodes.com/stride/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/stride/addrbook.json
PORT=26
DENOM=ustrd
GO_VERSION="1.19.3"
PEERS="b212d5740b2e11e54f56b072dc13b6134650cfb5@164.152.160.97:26656,a7d96dc929824613315dcc1c90fee119f28cc51f@164.152.160.155:26656,a988534ab1e4bc42aad26ea7ec7bdc7d5415a14c@107.6.2.27:32670,8ade90b45b991088c92e8583e8bc93589d6cd81e@84.244.95.247:26656,d2247f7b919f0781c90ee61958d7044665a22d38@169.155.44.213:26656,6b615c7dde3e76de39474b7406bdde0ac0f31b79@23.88.69.22:28666,493491c8904aa65f7173f4be7dc760099cb33595@132.145.203.191:26656,222b5f1f8f8b4933c1913818ab2b7379c282b4e2@65.108.75.107:11656,df3f533e6b9776c11f08da804edcb810cbdd2080@65.108.234.23:12256,bbe196ec7c537e9dac0d2575350a1aa64700cdef@129.213.159.218:26656,1483ddbd1ba369c01d5496877314ed1b09bd9cc3@65.21.189.221:12256,0d8efc8205826a74867dd063c30aa24342dd652b@83.136.251.210:26656,1ec2a654e00e22279ee50f13f074f2bce7218681@15.235.114.194:10156,2254e6968e5c7ebc98ef5b79b388502fa44e10e1@5.161.134.44:26656,0559809b9788925f85928f7b518e4315c090b4be@65.108.110.204:26656,20f56a68a04eedc764b7e1b87b7032a50b9d4fe9@51.81.155.97:10456,5093547fdf0430143ac66b4ee55d80e6542a6c10@217.174.247.163:26656,718ce477a62a14efe61571bd836fd3db9e43e6c1@38.105.232.61:26656,aa748c7a29d501d82f9861ab9777c10dd1737dc9@213.239.213.142:12256,d36ac7580cc8907a00b0add8c3b047caea6df4ed@107.155.67.202:26636,66807a69e4920359a7c064856edd1439a656e517@65.108.234.159:56656,be546a9a1b8b664a32ad5f45fa1d4087b44e0f83@135.181.214.120:26656,c4688bb34164eacacaa374bc7440b87986dd87ac@162.251.235.252:26656,44e797771bff124693e63a8ec331d42873cf2ae2@95.217.202.49:35656,04b797b5a56fb939a97a3c7d9c3230d09b85e8d7@93.189.30.118:26656,c948379b649bc6609557dd74f5a4e70716f100ea@51.210.240.201:10456,69fc32ac94aa1ccbac270fa58370459e647c251f@5.9.66.9:26656,e4ef38aea46aed22c4241f691104e164df6fc15a@65.109.33.48:15656,022fd83f945fe03f9155fced534c90b5ce8db979@65.109.23.238:36656,a7b4cf6f65138ba61518c2c45402da32dc8e28b7@88.99.164.158:21016,cc35475fe1f7c345af0ea8a692f3b4b41c8f12a2@116.202.36.240:10156,6831d67983cf5ebcb44da01737ccd6ccbd15c08e@193.70.47.90:12256,c9027c0429bca7dc7a441d7764d404d50694c225@66.206.17.178:26665,d9bfa29e0cf9c4ce0cc9c26d98e5d97228f93b0b@65.109.88.38:11656,bf0f5782650ddbf8121543b94705e5849f87120a@130.211.230.106:26656,7ab3bfcdbe618ed62317cbc40ef48aee783fb2b4@144.76.152.68:4656,233e06cfa51d53e186afe032e848f5c9f5cd4a01@83.171.248.3:26656,c938bcc723f004798750c3c533e8a6735f6d8363@38.146.3.122:12256,dff2539e4f13af52205c72e2992ad5c1705b44d4@51.91.152.102:36188,3023b940ec9a39661c95877cec99e17416dc2a17@51.89.6.150:21656,6fca686eca83017f3bb3055c3b58a2f8d476de8f@204.93.241.110:27652,e9ad059b88d593682307587b5c04a16a43893c5e@65.21.205.225:4656,48ab642db71cf3620a04ee15078b8a23bb443ae3@65.108.227.43:26656,a83cd29f4f9a4711346184966f9fb6c80bb658d2@65.108.103.184:21656,3fef899adcdeded56f6c69fe55c5da1624303367@163.172.101.208:4656,e41dd510feb9e14df82ce0f4eab258fad78645ea@158.247.218.149:10002,6443d6883d473772d84dabab8f965fdb098fa842@135.181.142.60:15606,40f4fa9cf89c380e7b65fc9a74030edfd61c38e3@145.239.7.196:26656,7ec6917a0519decec00a9a29f599c4d90ebf3b86@65.21.136.170:51656,8324d459d12f468199f6d1ec45b18ade35af18b8@5.78.104.216:26656,e3acd71e2a35efd98dc6038a156ee3de1f3b08bd@51.89.7.234:26639,abaf98731ce081fa2f32da7db0ff27b1db1c1c99@80.64.208.151:26656,94ac158d26b26c8ad924bde0aff9ce2e33d557f4@65.108.64.48:26656,a206a5ff59132c3f771735dec337432e6cfb2f7c@15.235.53.45:2062,5af431abc2f72f7143289d15bd226aa3da728413@5.9.106.214:10256,575ba8674ca8507f0edf9c0824a980ac11862c4a@85.10.200.231:24095,474893e4c5c0970d70db5612e24a54ebd87abeac@95.217.192.173:6000,8126946858991cc776f8ee3b6528d02af05f41aa@188.34.191.2:27056,fa34ce7ca08381d69278201e6386d3b7031e463f@162.55.163.71:26656,a424cd8cc8d5fdb714d3d93daeb10509b28c7e27@85.214.29.87:26656,28ca5fc2464e9494e8d5bd93955cde707e4e208e@34.27.254.51:26656,603310cb6a9bf8370bd143ae055f24d461417080@138.201.220.51:26666,3505b1ece40f94cab8f80cfe31f5106c028ccd05@185.193.17.40:12256,a3f95b0b15c31a68a7535f6068c4e14b95e90dcf@65.109.92.240:21016,ea6a7b2f366bc343f0670f1673fd86001dd08eb0@65.108.122.246:26636,dde569420829b5ec2a69bc0dd2fb1619e98cb19f@51.81.107.95:10456,2a65870799c0069e580f4be16c7e3b60fd774522@65.109.32.148:26786,7677a0ba7d46f80937df5149fbaef3749dba362e@159.89.7.173:26656,0c900d88aab9212e00607c756b152465a830723c@37.59.21.96:12256,ade7d4d0009c7725ee991b8c40a7f646f76bf1e3@149.102.140.108:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:12256"

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

echo "50 installation_progress"

sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make build
make install
sleep 1

echo "65 installation_progress"

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

echo "85 installation_progress"

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




#fast sync with snapshot
SNAPSHOT=https://snapshots.kjnodes.com/stride/snapshot_latest.tar.lz4
cp $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup
rm -rf $HOME/$SYSTEM_FOLDER/data/*
mv $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json
curl -L $SNAPSHOT | tar -Ilz4 -xf - -C $HOME/$SYSTEM_FOLDER




sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile

