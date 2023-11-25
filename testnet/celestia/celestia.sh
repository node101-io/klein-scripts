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
PROJECT=celestia
EXECUTE=celestia-appd
CHAIN_ID=mocha-4
SYSTEM_FOLDER=.celestia-app
PROJECT_FOLDER=celestia-app
RPC_URL=https://celestia-testnet-rpc.polkachu.com
VERSION='v'$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/celestiaorg/celestia-app.git
GENESIS_FILE=https://snapshots.kjnodes.com/celestia-testnet/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/celestia-testnet/addrbook.json
PORT=26
DENOM=utia
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | grep '^go' | sed 's/^go//')
PEERS="5c82cf33a32f40e2d914da1864927865d8d3824c@65.108.231.124:11656,12950e988c399aa6be0568c11b127a601cda47a5@154.26.155.102:26656,5c2a752c9b1952dbed075c56c600c3a79b58c395@195.3.220.54:27206,9369d4b730e3cfe2b18d0bf12e2f73a6441c2c5a@52.14.139.29:26656,e409695e0fcd1a2b521bae27621dca4686cb1ccc@198.199.70.16:26656,b24553f11f17482049c035b28598db644d88f26d@85.207.33.76:26656,e899a7b4d178b3581e90aa7c93c9105f5de274b9@3.138.86.185:26656,5a7566aa030f7e5e7114dc9764f944b2b1324bcd@65.109.23.114:11656,cc9587acdc5c6dc677160afe40599ae216955ae0@34.198.224.121:26656,88649cacbf4902a3353bd379f1b486d485747080@213.168.227.52:26656,0e37bc29501aef4562fd3e8048afa47bc2669424@50.19.243.132:26656,0893dfd0f9e82724f14a2e0ec0d7ad6461fb35b8@65.21.94.31:26656,f05e6a065b772dda4c7c0cbed40894a8c43416c7@51.68.166.235:26656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:12056,d1e02b19b67cf738575a5d6e29277682d66c1f82@146.190.151.193:32447,2c6b4cb9d9790a4c5d234fc5d150ffb41cdbc5db@94.130.132.227:3000,6d996aeed0402ce5da57c1272eb33f7b38c183ec@43.157.38.30:26656,2abbf1892ce9d91acbbc55b112f3561b01fc3465@162.62.126.26:26656,0640e5f6916438c593c888469637bbc0d3151784@185.252.220.89:25009,a0fa79691d6e57003236aa75050e7cd3a0cf7d1b@51.79.19.101:26656,315b63d7c9a19803b780224085dbe4bf00a7d87d@86.48.5.237:26656,c225e669599a31a788f7f9d316f2c78bc63747d9@185.119.116.231:26656,0f3ac66e2f7aecafd7fe31d52558121a75d3da2e@89.58.32.218:27665,7da1b277731b27edb61bb0c0339012bfdcf73a25@85.239.241.107:26656,375d2c99eaf23176b7b09a133a912f1a8e9e15f8@51.159.223.25:30656,3e30bcfc55e7d351f18144aab4b0973e9e9bf987@65.108.226.183:11656,10297d22a2f1f66bfb9f2c8f7d7152660bfffd92@65.109.32.148:26116"
SEEDS="3f472746f46493309650e5a033076689996c8881@celestia-testnet.rpc.kjnodes.com:12059"

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

# Prepare binaries for Cosmovisor
mkdir -p $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin
mv build/${EXECUTE} $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin/
rm -rf build

# Create application symlinks
sudo ln -s $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis $HOME/${SYSTEM_FOLDER}/cosmovisor/current -f
sudo ln -s $HOME/${SYSTEM_FOLDER}/cosmovisor/current/bin/${EXECUTE} /usr/local/bin/${EXECUTE} -f

# Download and install Cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.005$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

#fast sync with snapshot
SNAPSHOT=https://snapshots.kjnodes.com/celestia-testnet/snapshot_latest.tar.lz4
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