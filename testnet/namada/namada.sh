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
EXECUTE=namadad
CHAIN_ID=public-testnet-10.3718993c3648
# Namada variables
NAMADA_PROJECT_FOLDER=namada
NAMADA_VERSION=v0.17.5
NAMADA_REPO=https://github.com/anoma/namada.git
# CometBFT variables
CometBFT_PROJECT_FOLDER=cometbft
CometBFT_VERSION=v0.37.2
CometBFT_REPO=https://github.com/cometbft/cometbft.git
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')

sleep 2

echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export CHAIN_ID=${CHAIN_ID}" >> $HOME/.bash_profile
echo "export NAMADA_PROJECT_FOLDER=${NAMADA_PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export NAMADA_VERSION=${NAMADA_VERSION}" >> $HOME/.bash_profile
echo "export NAMADA_REPO=${NAMADA_REPO}" >> $HOME/.bash_profile
echo "export CometBFT_PROJECT_FOLDER=${CometBFT_PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export CometBFT_VERSION=${CometBFT_VERSION}" >> $HOME/.bash_profile
echo "export CometBFT_REPO=${CometBFT_REPO}" >> $HOME/.bash_profile
echo "export GO_VERSION=${GO_VERSION}" >> $HOME/.bash_profile

source $HOME/.bash_profile

sleep 1
if [ ! $MONIKER ]; then
	read -p "ENTER MONIKER NAME: " MONIKER
	echo 'export MONIKER='$MONIKER >> $HOME/.bash_profile
fi

echo "5 installation_progress"

# Updates
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config git make libssl-dev libclang-dev libclang-12-dev -y
sudo apt install jq build-essential bsdmainutils ncdu gcc git-core chrony liblz4-tool -y
sudo apt install uidmap dbus-user-session protobuf-compiler unzip -y

echo "30 installation_progress"

# Rust installation
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Go installation
cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

# Install protobuf
cd $HOME && rustup update
PROTOC_ZIP=protoc-23.3-linux-x86_64.zip
curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v23.3/$PROTOC_ZIP
sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
sudo unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
rm -f $PROTOC_ZIP

protoc --version

sleep 1

# Namada installation
cd $HOME
rm -rf $NAMADA_PROJECT_FOLDER
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

# Copy binaries
cd $HOME && cp $HOME/cometbft/build/cometbft /usr/local/bin/cometbft && \
cp "$HOME/namada/target/release/namada" /usr/local/bin/namada && \
cp "$HOME/namada/target/release/namadac" /usr/local/bin/namadac && \
cp "$HOME/namada/target/release/namadan" /usr/local/bin/namadan && \
cp "$HOME/namada/target/release/namadaw" /usr/local/bin/namadaw

echo "85 installation_progress"

# Join network
cd $HOME && namada client utils join-network --chain-id $CHAIN_ID

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile

