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
VERSION=v9.0.1
REPO=https://github.com/Stride-Labs/stride.git
GENESIS_FILE=https://snapshots.kjnodes.com/stride/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/stride/addrbook.json
PORT=26
DENOM=ustrd
GO_VERSION="1.19.3"
PEERS=aa748c7a29d501d82f9861ab9777c10dd1737dc9@213.239.213.142:12256,d36ac7580cc8907a00b0add8c3b047caea6df4ed@107.155.67.202:26636,8126946858991cc776f8ee3b6528d02af05f41aa@188.34.191.2:27056,575ba8674ca8507f0edf9c0824a980ac11862c4a@85.10.200.231:24095,2f02a4012f90f5d1a9a85748dd9aa14155ed4a71@66.172.36.134:28656,ea6a7b2f366bc343f0670f1673fd86001dd08eb0@65.108.122.246:26636,2a65870799c0069e580f4be16c7e3b60fd774522@65.109.32.148:26786,b7645e17efb21d31aa718cf7f1cf249650d81de4@85.10.203.235:26696,2f6a21a94be87df4c2a2d82683e6ea99b7b6b02b@50.21.173.78:26656,e8be5c472174a97a3d3076bd33be75f5fde92a5b@151.106.40.38:29656,0c900d88aab9212e00607c756b152465a830723c@37.59.21.96:12256,be546a9a1b8b664a32ad5f45fa1d4087b44e0f83@135.181.214.120:26656,a7b4cf6f65138ba61518c2c45402da32dc8e28b7@88.99.164.158:21016,0003bf00c79e8ebd1f31c0f83ad3d181f97f98e9@62.109.17.96:26656,b212d5740b2e11e54f56b072dc13b6134650cfb5@164.152.160.97:26656,1ec2a654e00e22279ee50f13f074f2bce7218681@15.235.114.194:10156,44e797771bff124693e63a8ec331d42873cf2ae2@95.217.202.49:35656,a1f479dc2e3322c6547a39c6c7eef5a191def57f@34.132.213.169:26656,222b5f1f8f8b4933c1913818ab2b7379c282b4e2@65.108.75.107:11656,8d7c56ad8bc08b4e98b2b2199bf194f6c25658b1@162.55.245.149:2030,a83cd29f4f9a4711346184966f9fb6c80bb658d2@65.108.103.184:21656,c938bcc723f004798750c3c533e8a6735f6d8363@38.146.3.122:12256,65ae054d22c83eb586fe4b175b52564d5383a80f@158.160.11.206:26656,8ade90b45b991088c92e8583e8bc93589d6cd81e@84.244.95.247:26656,dde569420829b5ec2a69bc0dd2fb1619e98cb19f@51.81.107.95:10456,89757803f40da51678451735445ad40d5b15e059@169.155.168.67:26656,718ce477a62a14efe61571bd836fd3db9e43e6c1@38.105.232.61:26656,b549e0f88cbebe6cfd3f772937a70640b950fd98@66.172.36.133:28656,fc305427390397f8c4eebe5bc22919c1cc5d4532@65.109.43.75:27007,f420eab70caad310ad6cc1990c977cadf193264c@51.159.80.121:6000,d2247f7b919f0781c90ee61958d7044665a22d38@169.155.44.213:26656,c9027c0429bca7dc7a441d7764d404d50694c225@66.206.17.178:26665,a7d96dc929824613315dcc1c90fee119f28cc51f@164.152.160.155:26656,0198f6d3ebe7bed4d176558a2ce8d341531f3e7b@74.80.183.130:26653,d056dcd5ac8dddb23e2962a5ade6ee51f9bfd785@162.19.89.8:10456,3023b940ec9a39661c95877cec99e17416dc2a17@51.89.6.150:21656,5af431abc2f72f7143289d15bd226aa3da728413@5.9.106.214:10256,022fd83f945fe03f9155fced534c90b5ce8db979@65.109.23.238:36656,9602f5eb0aab09c4090d0ecc1920178ac13941ae@141.95.66.1:27602,3fef899adcdeded56f6c69fe55c5da1624303367@163.172.101.208:4656,dff2539e4f13af52205c72e2992ad5c1705b44d4@51.91.152.102:36188,e41dd510feb9e14df82ce0f4eab258fad78645ea@158.247.218.149:10002,cb6ae22e1e89d029c55f2cb400b0caa19cbe5523@172.111.52.51:32661,a206a5ff59132c3f771735dec337432e6cfb2f7c@15.235.53.45:2062,cc35475fe1f7c345af0ea8a692f3b4b41c8f12a2@116.202.36.240:10156,aa0d47509ecadb630189fe4ef071d438a6493e69@178.162.165.194:24095,6fca686eca83017f3bb3055c3b58a2f8d476de8f@204.93.241.110:27652,777274fb08ed48a4e027664e2576a8460272e43c@15.235.115.153:26656,b5f9fa874781f975687018ae559f0d952d3a2e24@52.52.208.179:26656,abaf98731ce081fa2f32da7db0ff27b1db1c1c99@80.64.208.151:26656,2254e6968e5c7ebc98ef5b79b388502fa44e10e1@5.161.134.44:26656,6443d6883d473772d84dabab8f965fdb098fa842@135.181.142.60:15606,921b74b0d483b13e786becb7fc196671d90e3fab@66.172.36.137:28656,ed857708c330334e1e62751470d6ecddf0397459@65.109.69.59:12256,dfc62810eeaab86587b2975c79f3c12d4830652d@15.235.114.54:26656,8324d459d12f468199f6d1ec45b18ade35af18b8@5.78.104.216:26656,04b797b5a56fb939a97a3c7d9c3230d09b85e8d7@93.189.30.118:26656,9ee75491e354965d8bfd8434aa093f8613bc1dce@65.108.238.103:12256,493491c8904aa65f7173f4be7dc760099cb33595@132.145.203.191:26656,d9bfa29e0cf9c4ce0cc9c26d98e5d97228f93b0b@65.109.88.38:11656,3a0cf2ec11d98ec683fe196014a21b4b6350343f@176.9.117.204:26656,df43d9a9490495aa528431077b526eabeec46b52@95.217.197.100:26653,1483ddbd1ba369c01d5496877314ed1b09bd9cc3@65.21.189.221:12256,87a7a8cc67967d0ede5d68a1477c44a40a8705f7@108.165.178.242:26653,474893e4c5c0970d70db5612e24a54ebd87abeac@95.217.192.173:6000,20f56a68a04eedc764b7e1b87b7032a50b9d4fe9@51.81.155.97:10456,a3f95b0b15c31a68a7535f6068c4e14b95e90dcf@65.109.92.240:21016,3963b7cd5230ae2ba6800375421982d535a133e3@35.79.215.251:26656,df3f533e6b9776c11f08da804edcb810cbdd2080@65.108.234.23:12256,e9ad059b88d593682307587b5c04a16a43893c5e@65.21.205.225:4656,c948379b649bc6609557dd74f5a4e70716f100ea@51.210.240.201:10456
SEEDS="400f3d9e30b69e78a7fb891f60d76fa3c73f0ecc@stride.rpc.kjnodes.com:11659"

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
# sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
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




#state sync
cp $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup

STATE_SYNC_RPC=https://stride.rpc.kjnodes.com:443
STATE_SYNC_PEER=e821acdaf0c7a3c60ea3cd4eb4a98a62dad06f58@43.201.12.41:26656,df3f533e6b9776c11f08da804edcb810cbdd2080@65.108.234.23:12256,e821acdaf0c7a3c60ea3cd4eb4a98a62dad06f58@43.201.12.41:26656,a7b4cf6f65138ba61518c2c45402da32dc8e28b7@stride.peer.stavr.tech:21016,b5f9fa874781f975687018ae559f0d952d3a2e24@52.52.208.179:26656,ebc272824924ea1a27ea3183dd0b9ba713494f83@stride-mainnet-peer.autostake.com:26886,ced7684f4d60399986cdbc1465ac00a420a14202@peer-stride-01.stakeflow.io:1807,4d17c6e85a1e6282efee950ff3dfe85b4b043f0f@148.251.51.144:26656


LATEST_HEIGHT=$(curl -s $STATE_SYNC_RPC/block | jq -r .result.block.header.height)
SYNC_BLOCK_HEIGHT=$(($LATEST_HEIGHT - 1000))
SYNC_BLOCK_HASH=$(curl -s "$STATE_SYNC_RPC/block?height=$SYNC_BLOCK_HEIGHT" | jq -r .result.block_id.hash)
sed -i \
  -e "s|^enable *=.*|enable = true|" \
  -e "s|^rpc_servers *=.*|rpc_servers = \"$STATE_SYNC_RPC,$STATE_SYNC_RPC\"|" \
  -e "s|^trust_height *=.*|trust_height = $SYNC_BLOCK_HEIGHT|" \
  -e "s|^trust_hash *=.*|trust_hash = \"$SYNC_BLOCK_HASH\"|" \
  -e "s|^persistent_peers *=.*|persistent_peers = \"$STATE_SYNC_PEER\"|" \
  $HOME/$SYSTEM_FOLDER/config/config.toml
mv $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json




sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile

