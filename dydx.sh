#!/bin/bash

# Install necessary tools
sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop net-tools lsof -y < "/dev/null" && sudo apt-get update -y && sudo apt-get install wget liblz4-tool aria2 -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

# Define variables
EXECUTE=dydxprotocold
CHAIN_ID=dydx-testnet-1
MONIKER="Moniker"
KEY_NAME="Key Name"
VALIDATOR_ADDRESS="Validator Address"
COSMOVISOR_REPO="provenance-io/cosmovisor"
DYDXPROTOCOL_REPO="dydxprotocol/networks"
DYDX_PLATFORM="<platform>"

COSMOVISOR_VERSION=$(curl -sL https://api.github.com/repos/$COSMOVISOR_REPO/releases/latest | jq -r ".tag_name")
BINARY_VERSION=$(curl -sL https://api.github.com/repos/$DYDXPROTOCOL_REPO/releases/latest | jq -r ".tag_name")

# Download and install Cosmovisor
mkdir -p $HOME/cosmovisor
wget https://github.com/$COSMOVISOR_REPO/releases/download/$COSMOVISOR_VERSION/cosmovisor_${COSMOVISOR_VERSION}_linux_amd64.tar.gz -P $HOME/cosmovisor
tar -xvf $HOME/cosmovisor/cosmovisor_${COSMOVISOR_VERSION}_linux_amd64.tar.gz -C $HOME/cosmovisor
sudo cp $HOME/cosmovisor/cosmovisor /usr/local/bin

# Clone the dydxprotocol networks repository and get the protocol binary
git clone git@github.com:$DYDXPROTOCOL_REPO.git
cd networks
git checkout main
git pull origin main
ls $CHAIN_ID/binaries/$BINARY_VERSION
tar -xvzf $CHAIN_ID/binaries/$BINARY_VERSION/$EXECUTE-$BINARY_VERSION-${DYDX_PLATFORM}.tar.gz
mkdir -p "${HOME}/local/bin"
export PATH="${HOME}/local/bin:$PATH"
cp build/$EXECUTE-$BINARY_VERSION-${DYDX_PLATFORM} "${HOME}/local/bin/dydxprotocold"
rm -R build 

# Verify the binary version
$EXECUTE version --long

# Save the chain ID in dydxprotocold config
$EXECUTE config chain-id $CHAIN_ID

# Initialize the node
rm -rf $HOME/.dydxprotocol
$EXECUTE init --chain-id=$CHAIN_ID $MONIKER

# Add genesis account and generate gentx
$EXECUTE add-genesis-account $VALIDATOR_ADDRESS 100000000000dv4tnt
$EXECUTE gentx $KEY_NAME 50000000000dv4tnt --chain-id $CHAIN_ID --moniker $MONIKER --keyring-backend test

# Submit gentx
git clone git@github.com:$DYDXPROTOCOL_REPO.git
git checkout -b $MONIKER/gentx
cp ~/.dydxprotocol/config/gentx/gentx-xxxxxxxxxxxx.json networks/$CHAIN_ID/gentx/gentx-$MONIKER.json
git add $CHAIN_ID/gentx/*
git commit -m "$MONIKER gentx"
git push origin $MONIKER/gentx
