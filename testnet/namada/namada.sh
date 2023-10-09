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

if [ ! $MONIKER ]; then
	read -p "ENTER MONIKER NAME: " MONIKER
	echo 'export MONIKER='$MONIKER >> $HOME/.bash_profile
fi

#install update and libs
cd $HOME
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config git make libssl-dev libclang-dev libclang-12-dev -y
sudo apt install jq build-essential bsdmainutils ncdu gcc git-core chrony liblz4-tool -y
sudo apt install uidmap dbus-user-session protobuf-compiler unzip -y

cd $HOME
  sudo apt update
  sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
  . $HOME/.cargo/env
  curl https://deb.nodesource.com/setup_18.x | sudo bash
  sudo apt install cargo nodejs -y < "/dev/null"
  
cargo --version
node -v

GO_VERSION="1.20.5"

# Go installation
cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile

go version

#  Protobuf installation
cd $HOME && rustup update
PROTOC_ZIP=protoc-23.3-linux-x86_64.zip
curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v23.3/$PROTOC_ZIP
sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
sudo unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
rm -f $PROTOC_ZIP

protoc --version

# Variables
EXECUTE=namadad
CHAIN_ID=public-testnet-13.facd514666d5
# Namada variables
NAMADA_PROJECT_FOLDER=namada
NAMADA_VERSION=v0.22.0
NAMADA_REPO=https://github.com/anoma/namada.git
# CometBFT variables
CometBFT_PROJECT_FOLDER=cometbft
CometBFT_VERSION=v0.37.2
CometBFT_REPO=https://github.com/cometbft/cometbft.git
BASE_DIR=$HOME/.local/share/namada
PORT=26

#Setting up variables
echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export CHAIN_ID=${CHAIN_ID}" >> $HOME/.bash_profile
echo "export NAMADA_PROJECT_FOLDER=${NAMADA_PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export NAMADA_VERSION=${NAMADA_VERSION}" >> $HOME/.bash_profile
echo "export NAMADA_REPO=${NAMADA_REPO}" >> $HOME/.bash_profile
echo "export CometBFT_PROJECT_FOLDER=${CometBFT_PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export CometBFT_VERSION=${CometBFT_VERSION}" >> $HOME/.bash_profile
echo "export CometBFT_REPO=${CometBFT_REPO}" >> $HOME/.bash_profile
echo "export BASE_DIR=${BASE_DIR}" >> $HOME/.bash_profile
echo "export PORT=${PORT}" >> $HOME/.bash_profile

source $HOME/.bash_profile

sleep 1

# Namada installation
cd $HOME
git clone $NAMADA_REPO
cd $NAMADA_PROJECT_FOLDER
git checkout $NAMADA_VERSION
make build-release

echo "60 installation_progress"

sleep 1

# CometBFT installation
cd $HOME
git clone $CometBFT_REPO
cd $CometBFT_PROJECT_FOLDER
git checkout $CometBFT_VERSION
make build

# Copy binaries to /usr/local/bin
cd $HOME && cp $HOME/cometbft/build/cometbft /usr/local/bin/cometbft && \
cp "$HOME/namada/target/release/namada" /usr/local/bin/namada && \
cp "$HOME/namada/target/release/namadac" /usr/local/bin/namadac && \
cp "$HOME/namada/target/release/namadan" /usr/local/bin/namadan && \
cp "$HOME/namada/target/release/namadaw" /usr/local/bin/namadaw && \
cp "$HOME/namada/target/release/namadar" /usr/local/bin/namadar

cometbft version
namada --version

#Make service
sudo tee /etc/systemd/system/namadad.service > /dev/null <<EOF
[Unit]
Description=namada
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.local/share/namada
Environment=TM_LOG_LEVEL=p2p:none,pex:error
Environment=NAMADA_CMT_STDOUT=true
ExecStart=/usr/local/bin/namada node ledger run 
StandardOutput=syslog
StandardError=syslog
Restart=always
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

# Make config
sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE

# Start service
cd $HOME
namada client utils join-network --chain-id $CHAIN_ID
sudo systemctl start $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile




cd $HOME && mkdir $HOME/namada_backup
cp -r $HOME/.local/share/namada/pre-genesis $HOME/namada_backup/
systemctl stop namadad && systemctl disable namadad
rm /usr/local/bin/namada /usr/local/bin/namadac /usr/local/bin/namadan /usr/local/bin/namadaw /usr/local/bin/namadar -rf
rm $HOME/.local/share/namada -rf
rm -rf $HOME/.masp-params

sudo apt update && sudo apt upgrade -y

#CHECK your vars in /.bash_profile and change if they not correctly
sed -i '/public-testnet/d' "$HOME/.bash_profile"
sed -i '/NAMADA_VERSION/d' "$HOME/.bash_profile"
sed -i '/WALLET_ADDRESS/d' "$HOME/.bash_profile"

NAMADA_VERSION=v0.23.0
CHAIN_ID=public-testnet-14.5d79b6958580

echo "export BASE_DIR=$HOME/.local/share/namada" >> ~/.bash_profile
echo "export NAMADA_VERSION=$NAMADA_VERSION" >> ~/.bash_profile
echo "export CHAIN_ID=$CHAIN_ID" >> ~/.bash_profile
source ~/.bash_profile

cd $HOME/namada
git fetch && git checkout $NAMADA_VERSION
make build-release
cargo fix --lib -p namada_apps

cd $HOME && cp "$HOME/namada/target/release/namada" /usr/local/bin/namada && \
cp "$HOME/namada/target/release/namadac" /usr/local/bin/namadac && \
cp "$HOME/namada/target/release/namadan" /usr/local/bin/namadan && \
cp "$HOME/namada/target/release/namadaw" /usr/local/bin/namadaw && \
cp "$HOME/namada/target/release/namadar" /usr/local/bin/namadar
systemctl enable namadad

#check version
namada --version
#output: Namada v0.23.0