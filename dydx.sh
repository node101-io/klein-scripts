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

# Install Git
sudo apt-get install -y git

# Install Go
wget https://golang.org/dl/go1.20.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz
rm go1.20.5.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version

# Install cosmovisor
echo "Installing Cosmovisor..."
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@latest

# Initialize node and setup validator
export BINARY_VERSION="v0.0.1-rc1"
export DYDX_PLATFORM="linux-amd64"
export DYDX_MONIKER="node101"
export DYDX_KEY_NAME="wallet101"

git clone git@github.com:dydxprotocol/networks.git
cd networks
git checkout main
git pull origin main
tar -xvzf dydx-testnet-1/binaries/$BINARY_VERSION/dydxprotocold-$BINARY_VERSION-${DYDX_PLATFORM}.tar.gz
mkdir -p "${HOME}/local/bin"
export PATH="${HOME}/local/bin:$PATH"
cp build/dydxprotocold-$BINARY_VERSION-${DYDX_PLATFORM} "${HOME}/local/bin/dydxprotocold"
rm -R build
dydxprotocold version --long
dydxprotocold config chain-id dydx-testnet-1
rm -rf $HOME/.dydxprotocol
dydxprotocold init --chain-id=dydx-testnet-1 $DYDX_MONIKER
dydxprotocold keys add $DYDX_KEY_NAME --keyring-backend test
MY_VALIDATOR_ADDRESS=$(dydxprotocold keys show $DYDX_KEY_NAME -a --keyring-backend test)
dydxprotocold add-genesis-account $MY_VALIDATOR_ADDRESS 100000000000dv4tnt
dydxprotocold gentx $DYDX_KEY_NAME 50000000000dv4tnt --chain-id dydx-testnet-1 --moniker $DYDX_MONIKER --keyring-backend test

Starting the Node
git checkout main
git pull origin main
cp dydx-testnet-1/genesis.json $HOME/.dydxprotocol/config/genesis.json
dydxprotocold start --p2p.seeds="25dd504d86d82673b9cf94fe78c00714f236c9f8@3.128.51.185:26656"
