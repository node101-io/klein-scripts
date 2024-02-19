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
PROJECT=babylon
EXECUTE=babylond
CHAIN_ID=bbn-test-2
SYSTEM_FOLDER=.babylond
PROJECT_FOLDER=babylon
RPC_URL=https://babylon-testnet-rpc.itrocket.net
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/babylonchain/babylon.git
GENESIS_FILE=https://snapshots.kjnodes.com/babylon-testnet/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/babylon-testnet/addrbook.json
PORT=26
DENOM=ubbn
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | grep '^go' | sed 's/^go//')
PEERS="2e7773b7d57e38bb6d77131c8f5bd8d3839b923a@142.132.200.248:16456,5e7d425632f7cb5ae145fb100f2f7ecf2d6f9f5c@158.220.103.208:16456,438ed646562c082715ec4791d4c10781a2fd8797@154.42.7.73:26656,a3b9cc15381df70a34644a966c81c44419daa936@185.208.206.227:26656,e90fcbd0fd960f733de3dc066ccd2135f4517977@207.180.216.237:26656,e94be79572019e9d5b5d25b88d486e107a4b3038@207.180.222.79:26656,ceab82760efd4ca0f61c6819f3a3ab5c60bb7432@144.91.123.239:16456,bfd425dbce14a2b01c8ac6f1072950515f10f71e@31.220.75.83:16456,a0e734209aa741a14dcecaf222e9c89d80b0e913@38.242.237.25:16456,011e4aee6c5295f3995242d881427d9d31605d3f@45.150.67.115:26656,f8f12010c03b971e8c3ac18a998d00a043cf37c8@154.12.229.189:26656,9bc861a767096e682f6a49f840df8c591ed73e04@173.249.26.215:16456,915572b13de421f36db915be9e34b21d450ab26b@84.247.190.57:31156,9475d5e7c7f0bb6bf2ff7b96d9bcca351cfc258d@38.242.240.251:31156,eb0e41c35e1f86ef6dfb0d1c7faf4a640d9e2356@95.111.248.16:16456,9afe248b225f81de850592ab400adfb22102c6e8@173.212.196.6:26656,17a193ea0fbbb4323e8a27f891460e38f3be6bc7@51.38.40.139:16456,bfcfd2dc58895776eee7f35fa4358eec61018efd@37.60.250.94:31156,7998eeb85e23f975d17efd176d9bd9882e638ce9@207.180.228.102:26656,6487620e16fe352eed9912c151bcb956def57a68@37.60.249.252:26656"
SEEDS="3f472746f46493309650e5a033076689996c8881@babylon-testnet.rpc.kjnodes.com:16459"

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
make install

sleep 1

# Prepare binaries for Cosmovisor
mkdir -p $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin
cp $(which $EXECUTE) $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin/

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.00001$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

# state sync
SNAPSHOT=https://snapshots-testnet.nodejumper.io/babylon-testnet/babylon-testnet_latest.tar.lz4
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