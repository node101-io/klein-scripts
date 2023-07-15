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
PROJECT=chihuahua
EXECUTE=chihuahuad
CHAIN_ID=chihuahua-1
SYSTEM_FOLDER=.chihuahuad
PROJECT_FOLDER=chihuahua
RPC_URL=https://chihuahua-rpc.polkachu.com
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/ChihuahuaChain/chihuahua.git
GENESIS_FILE=https://snapshots.polkachu.com/genesis/chihuahua/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/addrbook/chihuahua/addrbook.json
PORT=26
DENOM=uhuahua
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="865ce49df169de9aa0e9530ed3a9a22435c0fc13@213.239.214.73:6095,1ee20cf8befd9b48bebec4973ccd5ac9f7cdd552@62.171.132.248:26656,55f1b718e5e4d7a9ab58ad4747d3f9daa833f098@185.225.191.108:56656,54c27b84cb62be0300d27ef5ab7e77b21d85f14f@65.21.136.170:45656,176d693106948f3a5e27bd4c45e4d71d71513be4@104.193.254.115:26656,62af33efd5bf492038baff03bdc7924dd7528a10@155.133.22.208:23356,b5bee8a47c6034b8bfb8a07379417e099cea3ed0@65.108.71.166:58656,d40a6fa0d2592ee3ac5d8ffa0ea2646ad76a18ce@188.165.230.75:12956,982e8c3c0c7e335bec561df5b1434faf6ab21fa3@185.111.159.232:2000,16b233ebedd6a88ba298f37cbe8a9fb2e6358fa5@135.181.215.62:3440,35c4ddfed043793d0c9fb8555cd1623fb46f5128@148.251.13.186:12956,e1998e8c657d2ef9ba90567981f10628a8654220@85.237.193.109:26656,1cec8755f8cd7153fbaebc3d20793c0eaea9d4a2@162.19.95.239:12956,ea3fbfba42f063c4f00aa41ebb6e1161b63e09e8@15.235.114.194:10356,aa30ee7e94ac37b86edad53c32a65df74dc2bad8@95.217.41.162:26656,41caa4106f68977e3a5123e56f57934a2d34a1c1@185.16.38.210:27186,a832b6f57139b8c4c18048394a35ecebcfd1c0f0@65.108.137.37:26656,561eb93e3d8a09afd5cb3bb4ce988d4767ab1698@142.44.138.212:26656,2bc2e7c2df7bd56edf4c88c237cf917504392c86@162.55.92.114:2050,2faf86d3587c1f6ee4cfce8434a6b5ef61e54c21@65.21.228.161:2000,323737e89b2119861c9015e5b9a06d8f52b2bd37@83.149.102.56:6095,ebc272824924ea1a27ea3183dd0b9ba713494f83@195.3.220.54:27186,acfd8c6af6b3ecbe729ebecc6e30f0c850f20ede@65.108.238.102:12956,3cdf06d75b225f949514a80b1f245bc2d75dc8a9@51.81.155.189:10156,6df7a60785506ad49fd034cd3e82377af61ab4cb@13.125.121.231:26656,2c82317311aba7f42bfdfb7a0fb466f460721ea0@116.202.36.240:10356,a9dff4b2b5232b0513f1214e1f8104284f2cc327@85.239.233.56:2000,b59a7da2738b2c750dfd0dbb5dc0f3c690039dd2@154.53.60.236:26656,f0266cd6868233b94e94c986cca8fce5ee16246e@65.108.126.215:26656,f924bd81748ec9aa8ac6b2f976bb0c4d477d685d@95.214.55.210:26656,89b576c3eb72a4f0c66dc0899bec7c21552ea2a5@23.88.7.73:29538,f457868b0379a07a7995d64e563585ee765b81f5@74.96.207.60:26656,d330c34127b53321e47b02d5f24337e6983cecdf@65.108.232.104:12956,d542a7b1798285c7d2dd58defbe5cddc811bdc75@138.68.40.251:26656,89757803f40da51678451735445ad40d5b15e059@169.155.169.156:26656,8e538cc06ef5493a12c5238831dc81ebd8f0dcb3@167.235.240.250:26656,b7257ccb6bf587d12d5dee5761a71708a202f45e@173.215.85.171:20100,1175bd0f0e948f1737cdbe4add325cea4418a962@198.244.200.229:26656,3381830ad8cfcfe7d5604f4758b43adde62809d2@141.94.109.71:10156,a9640eb569620d1f7be018a9e1919b0357a18b8c@38.146.3.160:12956,2e1e9ccd68c1f25016168fc050aed900b553fdb0@185.242.112.32:56646,8d4becbf24a3782bd5995d89d5126d0dca28345e@135.181.90.213:12956,f01a0195f6e00e4384be16950a50f677c9abc60d@193.70.45.106:12956,6e86b2a5bb3778db9519d1567e5bcbe4e68c7f82@65.21.200.142:12956,c382a9a0d4c0606d785d2c7c2673a0825f7c53b2@65.21.131.216:27756,7549de9e4fada385ec0bd2807f83f7d97c6a15ec@89.58.18.61:2000,751e66df56b5215595dc664ba650f94fe2eca765@136.243.67.44:12956,dde6d562c36d78fa2e3e4d62cde94a99c43f2c25@65.109.89.19:12956,a8f339d59480908c9b1c420735ed15f577f218c5@185.119.118.112:3000,c2ef001f240ba7951a0bf851e5be6975382ca683@198.244.179.233:26656,e726816f42831689eab9378d5d577f1d06d25716@134.65.195.93:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:12956"

sleep 2

echo "export PROJECT=${PROJECT}" >> $HOME/.bash_profile
echo "export SNAPSHOT_URL=${SNAPSHOT_URL}" >> $HOME/.bash_profile
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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"10$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

#fast sync with snapshot
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

