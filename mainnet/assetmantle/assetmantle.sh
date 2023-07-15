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
PROJECT=assetmantle
EXECUTE=mantleNode
CHAIN_ID=mantle-1
SYSTEM_FOLDER=.mantleNode
PROJECT_FOLDER=node
VERSION=v0.3.0
REPO=https://github.com/AssetMantle/node.git
GENESIS_FILE=https://snapshots.polkachu.com/genesis/assetmantle/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/addrbook/assetmantle/addrbook.json
PORT=26
DENOM=umntl
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="df406a21ac70fbcd7ae06448fe0e7b428385ec6f@65.21.195.98:26656,89757803f40da51678451735445ad40d5b15e059@164.152.160.22:26656,96b7e522a5dfd6d41d9e75895a2db7bb2c5e83d6@95.214.52.138:26656,113a2a4c89c4e557f5e5f85eea729907e7720d12@138.201.222.230:26686,e4b985f2a609baec86af2e2af45cf1ae5bae2d50@5.34.179.199:26656,4039dc9fdc59412a9dfedac49eaee8e07c2415e6@23.88.62.189:27003,e1718c020d26d76a63a5496086f8a5ff68fb8de7@165.227.13.116:26656,9dfee52057487fdb2bd8421768a16f7412797b37@167.235.211.122:26656,38f4504f74a9fd70f158270751c31a4d146f987c@142.132.152.46:12656,f61e5c1d7897dd445508a873248e57ae553ac258@95.216.102.235:53759,8a9494ae1337efe0df805281a7ba20ddf6be1ad3@5.199.163.76:26656,3445d0e74d4c52d46b91be893b8b3027dd895413@165.227.166.249:26656,68692140af51d0c41163340f6f1222eec914c18f@142.132.248.138:26746,bc573679e48cd5aeb8ac0b222a886cfaf3f70368@88.99.192.187:46656,cbb1bb6b073e65bb5a9a349e8ac2bb86348b5da1@142.132.210.135:26656,7f150cae7e3a0c63bee9e9fdadb0165096947deb@15.235.114.194:10256,8f0920cc298354c536845a5bfb19e5c3e1b42913@198.37.107.164:26656,94e3151dddac887e84b42c309e24c33ceae8026e@144.76.16.29:26656,c75a48b7dfbad051443eb79db51ab7ccc770e152@65.109.106.172:28656,a9a18c182cdc0b787565962301d96d19c9202b1a@51.81.155.189:10256,f073d57107004268a7c0f1e24433401f892eff94@144.76.63.67:26229,169a3e12d45903d961ace560a384d3bcb55092e2@3.138.118.210:26656,684ca0ac72dd5e42a9a3f1e7985acfb1828e6429@2.138.201.93:46656,5898bc79cbcbf288019363edd7f8237cb433d18c@65.21.225.207:10156,4a3a422dae276960070630ff809aba341841e65e@85.10.198.171:26656,4e1c2471efb89239fb04a4b75f9f87177fd91d00@134.65.194.95:26656,b212d5740b2e11e54f56b072dc13b6134650cfb5@169.155.45.218:26656,d2a16801e996bc71ddb2e30027a006b12b4cbcb6@62.171.182.242:23656,f2dd2c427ad98e4e4b4666fc477331377aa8c372@135.125.163.63:26646,7a29d52e27a3a663b32bf7fabcea5966e8640760@88.198.66.25:46656,767635fe9d2f35b9bfbcf40ad5d2e355bf9b15d3@13.234.225.229:26656,52afed38019330fa441af04a3c52bf6425227b3f@88.99.71.158:46656,e726816f42831689eab9378d5d577f1d06d25716@169.155.171.1:26656,e1b058e5cfa2b836ddaa496b10911da62dcf182e@138.201.8.248:26656,0fd90359a95ad4c35ae4ec3c8734aaa19834dfcf@176.126.87.56:26656"
SEEDS="10de5165a61dd83c768781d438748c14e11f4397@seed.assetmantle.one:26656"

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

echo "30 installation_progress"

# Go installation
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

# Download and install Cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0

# Create Cosmovisor Folders
mkdir -p ~/${SYSTEM_FOLDER}/cosmovisor/genesis/bin
mkdir -p ~/${SYSTEM_FOLDER}/cosmovisor/upgrades

# Load Node Binary into Cosmovisor Folder
cp ~/go/bin/$EXECUTE ~/${SYSTEM_FOLDER}/cosmovisor/genesis/bin

# Create service
sudo tee /etc/systemd/system/${EXECUTE}.service > /dev/null << EOF
[Unit]
Description=${EXECUTE}
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/${SYSTEM_FOLDER}"
Environment="DAEMON_NAME=${EXECUTE}"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/${SYSTEM_FOLDER}/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF

$EXECUTE config chain-id $CHAIN_ID
$EXECUTE config keyring-backend test
$EXECUTE config node tcp://localhost:${PORT}657
$EXECUTE init $MONIKER --chain-id $CHAIN_ID

# Set peers and seeds
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json

echo "75 installation_progress"

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

sleep 3 

# Extract URL from the snapshot JSON data
wget -q -O - https://polkachu.com/tendermint_snapshots/${PROJECT} > webpage.html
SNAPSHOT=$(grep -o "https://snapshots.polkachu.com/snapshots/${PROJECT}/${PROJECT}_[0-9]*.tar.lz4" webpage.html | head -n 1)
cp $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup
rm -rf $HOME/$SYSTEM_FOLDER/data/*
mv $HOME/$SYSTEM_FOLDER/priv_validator_state.json.backup $HOME/$SYSTEM_FOLDER/data/priv_validator_state.json
curl -L $SNAPSHOT | tar -I lz4 -xf - -C $HOME/$SYSTEM_FOLDER

# Upgrade info
[[ -f $HOME/$SYSTEM_FOLDER/data/upgrade-info.json ]] && cp $HOME/$SYSTEM_FOLDER/data/upgrade-info.json $HOME/$SYSTEM_FOLDER/cosmovisor/genesis/upgrade-info.json

sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile

