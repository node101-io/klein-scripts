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
PROJECT=cosmos
EXECUTE=gaiad
RPC_URL=https://cosmos-testnet-rpc.polkachu.com
CHAIN_ID=$(curl -s -L "${RPC_URL}/status?" | jq -r '.result.node_info.network')
SYSTEM_FOLDER=.gaia
PROJECT_FOLDER=gaia
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
if [[ $VERSION != v* ]]; then
  VERSION="v$VERSION"
fi
REPO=https://github.com/cosmos/gaia.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/cosmos/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/cosmos/addrbook.json
PORT=26
DENOM=uatom
GO_VERSION="1.20"
PEERS="ef515ee185ed2ae6cfb012da83431420273c53f9@136.243.88.91:2320,a4c679e745b6a24ab2c403631b2876e361f2377b@35.87.192.171:26656,e121e8bed6710d05e45f5a2ddf88107b360281c5@142.132.156.189:26656,f5772050cc2cab7dab946f2deb5e45ae1ea71dcc@148.251.133.248:14956,5a4475fe23124a5cabd13d27ce14eccedb2ba1b5@141.95.103.138:26656,29bc3833f3584eb795fc28653021cfa25d9bb9c6@82.100.58.103:30156,08cf0f37ca069d9f4027b0b6cb406c40c9fabb16@51.91.118.140:26656,e281bdf052dad68ccf40777cb7d25649a5b9fa26@207.180.219.160:36656,08ec17e86dac67b9da70deb20177655495a55407@147.182.145.105:26656,a53530c5bac43d5748e730f4f3abaa7b26d31ced@37.120.245.99:26656,8e0a92711c0233fa74caa36488e3ff22ea6dcb11@74.118.136.163:26656,12f1a242fc03515393af72430758790c8661a55c@157.90.176.184:22656,a2cfd24ca641a6d407b03d98595f4755b349df61@141.94.138.48:26676,d25ca51122f2bd7738001818eb39fd4919c8fe92@20.208.46.170:26656,86c9f2f5f252eee2b64cf0aec8059c86c88b8824@65.21.84.109:26656,3e085ac1382e57a62c770e11b334fb7a9a9c5daa@65.21.84.110:26656,032ac421764cdf5139e64510669cc519fe1e1193@37.120.245.83:26656,538d7bbc8ee2d5c6cd8bd12da935759cef006e5e@5.161.94.187:26656,abb2ddadc12f9135209d1dd03b3707f649ecbb7a@147.182.145.88:26656,328e0627172add338f6aed08600098a9308dc52d@147.182.145.103:26656,d1752a3dcfc9d3169c47853a82fe0d1ec79c0024@147.182.145.100:26656,4ea6e56300a2f37b90e58de5ee27d1c9065cf871@146.190.252.36:26656,d13d77428697308eacb1a6a33b42f72650bc511e@80.64.208.139:26656,f3208a4fc74c9f7326faabf2551d93d6e1fe69c2@222.106.187.13:40800,2c08aa7bc9e94304225ada5ddc30374f00942a90@138.201.204.5:43656,cd1cd8d95132857ae14825428e55eaffea36a597@195.14.6.2:26656,f2520026fb9086f1b2f09e132d209cbe88064ec1@146.190.161.210:25003,a46ce2df33f8de333d0dd127238cb9603110b92a@43.131.37.70:26656,794fcb57bb76c50515f31dc8e0e8d6536dea859d@178.239.197.182:26656,a2491114d865ecf0a29f46cec3c3c9c056979e83@194.163.159.174:26656,c06ccc969f874dfead9729f4d9a66cb9e512adf8@63.229.234.75:26656,5c8ea31510389054b2e9192a8dfaa7a0f0b3f0c5@51.81.208.63:14956,6483d2098cab9402c7931dc07181f42fbe3cc05f@148.251.177.108:14956,ca5c2c15856673dc79b8985377b28a9fc86b2188@57.128.20.118:29656,5fb5d0cd61d3ffcb4246a32321ea595827be6851@203.135.141.17:26656,92eb45963b0ef919d7d4cfd8faff05ade90637cc@65.109.85.226:2010,f74e384e48bb78d566297eb502f8059798bfe2e5@135.181.16.163:26001,070b8d6935313f66f3a55c61560802a255a4f968@43.157.44.61:26656,99ad87e4419cbea7c59b27e77442a457eda1dc21@65.21.202.61:25007,8d7627c01a0f133495d123aeffef4a4db0cee254@89.250.150.241:26656,16f1a499a17fbf5af888009b1a1f1f1d130ce2d3@63.229.234.76:26656,ad5c0ab231f9b0ed91ffbaee70fd082fd5e78ad4@65.109.85.225:2010,95dbb4b0bbe870c997878768c648cf9a4337cae8@45.250.253.30:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:14956"

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

#fast sync with snapshot
# wget -q -O - https://polkachu.com/testnets/${PROJECT}/snapshots > webpage.html
# SNAPSHOT=$(grep -o "https://snapshots.polkachu.com/testnet-snapshots/${PROJECT}/${PROJECT}_[0-9]*.tar.lz4" webpage.html | head -n 1)
SNAPSHOT=https://snapshots.kjnodes.com/cosmoshub-testnet/snapshot_latest.tar.lz4
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