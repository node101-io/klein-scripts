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
PROJECT=jackal
EXECUTE=canined
RPC_URL=https://jackal-testnet-rpc.polkachu.com/
CHAIN_ID=$(curl -s -L "${RPC_URL}/status?" | jq -r '.result.node_info.network')
VERSION=v3.0.0-rc.3
REPO=https://github.com/JackalLabs/canine-chain.git
SYSTEM_FOLDER=.canine
PROJECT_FOLDER=canine-chain
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/jackal/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/jackal/addrbook.json
PORT=26
DENOM=jkl
GO_VERSION="1.20" 
PEERS="712dd67b7abe08577d394e90a4930492c8f7d2ee@65.108.124.219:41656,0394449cab5a29f24dd4f37683d3b7622f27c0fc@65.108.206.118:61156,09d9127972ded9e22f9f11833ed7fcfa149cf1fa@65.109.92.240:19126,e4e93ce4b050c9d821e15b69477f5da706121343@65.109.93.152:31656,ec78732a7d5bdc1e27e8d7ac1bffe3881c9fb271@65.108.226.183:17556,39a2916c988ae1b7e4794ccc3eb74f45f75f7ca4@65.108.98.41:38656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:13756,251723a73f631ec2e4a09b487b4900d777c7181d@162.19.239.230:26656,34bb04a3e226493e5d142c74bf78d2ed2803ee9d@213.133.100.172:27464,1b191fb9ef837dec648136097f94925a15dd85ab@213.170.135.20:26516,dc84774683298e57a848b59b7c0d1a70477b4fc1@213.239.207.175:48656,2ededbdbd98580e22ae8c3676e37b6e1fc1d987b@142.132.248.253:23656,3c6d856a429224201d78c7f28026874d10a27f57@5.75.227.78:26656,ff5171d91cb033670238998dc84bdf69468bb053@51.89.232.234:27686,5eedbfbe64b942f4ab54db3842acf3bfab034c24@161.97.74.88:46656,80420ad774e622bda8e1dfa9b80da11eee7eed1f@144.126.140.252:29656,94b63fddfc78230f51aeb7ac34b9fb86bd042a77@142.132.200.233:30567,84af58201840781a0a62449d1dcdb0ad0cf5bdb3@91.223.3.144:26356,9a2c091798681f89b11f8eea370bf9c6284437c5@167.86.115.183:26656,f3e70d3de1974208af04dac6fabd657ab4abf0ff@65.108.75.107:24656,223617b887164ae4542f0b6647ad459ddef16b71@5.9.83.110:37656,27238e2f804bf28a14c186a2e0f0ceaae0d2588f@176.9.98.24:30566,999672db41dfc26e4880726c65e79ddadac89f7e@37.120.191.47:46656,4ea723e652f11433734ae2aa6f364ef0510d6636@16.163.74.176:26626,a0f726a3dffb45d9cbde0913701bd757fcd7e434@157.90.2.254:36656,80613772b20df144945801b42f327d0945a24374@65.108.230.113:19126"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:17556"

if [[ $VERSION != v* ]]; then
  VERSION="v$VERSION"
fi

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

echo "20 installation_progress"

# Go installation
cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "30 installation_progress"

sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make build
make install

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

echo "50 installation_progress"

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

#fast sync with snapshot
wget -q -O - https://polkachu.com/testnets/${PROJECT}/snapshots > webpage.html
SNAPSHOT=$(grep -o "https://snapshots.polkachu.com/testnet-snapshots/${PROJECT}/${PROJECT}_[0-9]*.tar.lz4" webpage.html | head -n 1)
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

rm -- "$0"