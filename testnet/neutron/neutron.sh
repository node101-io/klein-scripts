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
PROJECT=neutron
EXECUTE=neutrond
CHAIN_ID=pion-1
SYSTEM_FOLDER=.neutrond
PROJECT_FOLDER=neutron
RPC_URL=https://neutron-testnet-rpc.polkachu.com
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
if [[ $VERSION != v* ]]; then
    VERSION="v$VERSION"
fi
REPO=https://github.com/neutron-org/neutron.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/neutron/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/neutron/addrbook.json
PORT=26
DENOM=untrn
GO_VERSION="1.20"
PEERS="76e4cedbe3e8f0dfcdb10a4a319fbe521666867f@148.251.177.108:19156,c6a6ebbf6079434be021438a7b7ed3649df429ec@142.132.203.60:26656,50bd49d6f0dd3bd5519572fc1522946c80702262@211.219.19.69:27656,f1eb68c6d08f03c173ed9e1d1a1f7e6152804808@43.157.42.169:26656,2083ecf2217c272ee72c34b1624c82d317b7cea9@136.38.55.33:26656,f59a0ce40854741cca4db39ab97257ee5931c6a1@51.91.118.140:16656,50c93c97ac61728705a3f787e6b7825b8957f44f@148.251.133.248:19156,1a5c3a7129a7e5ed33300710f2e90f60887f52eb@51.81.208.63:19156,a73bdeaf8cf41aad391f9544b68d8327c83e7038@38.109.200.33:26656,e281bdf052dad68ccf40777cb7d25649a5b9fa26@207.180.219.160:36556,c4d5921e2444e97279f91b9c070991853fa8e696@141.94.138.48:26682,98ee31d4f8ece6493339f52414501ff555a29cb8@65.109.25.113:19156,a2491114d865ecf0a29f46cec3c3c9c056979e83@194.163.159.174:26956,74646f588210390b67e9bdd7a575faaa1cb3ffaf@51.91.13.158:29656,1fa756a69758f518c2d30a44da230163d96fa60f@34.218.59.219:26656,cd1cd8d95132857ae14825428e55eaffea36a597@195.14.6.2:26656,349680130653abdb5a9eb0f533950f2c234826a1@34.87.125.75:26656,bb78bf67a6a5b83f802797c2378a93bc794480d2@88.198.8.79:2240,182507fa31da7c01b826acc31d402fc743bfb0f0@3.136.184.98:45711,6b57e46453bf5a3ae6b4633ce553e45ceb1432c5@95.217.44.105:46656,d13d77428697308eacb1a6a33b42f72650bc511e@80.64.208.139:26606,3b3ff4e9bff20646ba2fa1ffaff14cf5f73af2c4@65.109.91.165:2100,85185c7784382ad662e5e69946dbf01477ff1074@34.88.251.56:26656,c61e2d4cbc273d8c96bb918768ca0968edd11d95@37.120.245.99:16656,7836ed3e494c9cd16a625a4d5f73e3c988f1040a@57.128.20.118:27056,5eca3393308b5ad46d6cedb03e9b64e14b3c7468@185.252.220.89:26656,c4ead1f0482dd7524e751eb7bba7a2070315be72@162.62.61.107:26656,b0e1a54e0be7ff8af3caf457e29d217ca1184129@46.101.195.113:36656,20b4f9207cdc9d0310399f848f057621f7251846@222.106.187.13:44800,328a00ee256b3219e018a33b6cc124bc8b44249a@89.58.32.218:26661,5b0d2a70e449e1c32e6fdadf91f160f5b2fd542e@146.190.242.140:26656,0e569f6334ed5815224e8ec91d43ef2ab8083553@85.207.33.77:30256,ebbdd12c2817cacb919929393a69214294090864@162.19.237.67:26656,9f90244ff538106a6b6c8895b2db20f30b4bacef@63.229.234.75:26656,032ac421764cdf5139e64510669cc519fe1e1193@37.120.245.83:16656,f44aa4467a5c411f650fd9223644d70afc1eacd1@3.16.61.81:45511,a86f0c6f503b728cbd48218462dbee10d1ebea85@3.76.85.22:26896,0978578578149a1878fdf8267996cd5ceb4ff0eb@208.88.251.50:26656,3385094600dcce4da1d4617f8567b55531ac2691@65.109.85.221:2240,5fb5d0cd61d3ffcb4246a32321ea595827be6851@203.135.141.17:36656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:19156"

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