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
CHAIN_ID=provider
SYSTEM_FOLDER=.gaia
PROJECT_FOLDER=gaia
RPC_URL=https://cosmos-testnet-rpc.polkachu.com
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/cosmos/gaia.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/cosmos/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/cosmos/addrbook.json
PORT=26
DENOM=uatom
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="cd1cd8d95132857ae14825428e55eaffea36a597@195.14.6.2:26656,ef515ee185ed2ae6cfb012da83431420273c53f9@136.243.88.91:2320,f5772050cc2cab7dab946f2deb5e45ae1ea71dcc@148.251.133.248:14956,a2491114d865ecf0a29f46cec3c3c9c056979e83@194.163.159.174:26656,3f31c6038c69737d90f938e98438d20a5a3c0e03@5.75.245.174:26656,2c08aa7bc9e94304225ada5ddc30374f00942a90@138.201.204.5:43656,ad5c0ab231f9b0ed91ffbaee70fd082fd5e78ad4@65.109.85.225:2010,5a4475fe23124a5cabd13d27ce14eccedb2ba1b5@141.95.103.138:26656,3c83e791db6886c9ba478a4c5440f32f2f8a6df7@89.202.76.28:26656,ca5c2c15856673dc79b8985377b28a9fc86b2188@57.128.20.118:29656,8e0a92711c0233fa74caa36488e3ff22ea6dcb11@74.118.136.163:26656,4ea6e56300a2f37b90e58de5ee27d1c9065cf871@146.190.252.36:26656,032ac421764cdf5139e64510669cc519fe1e1193@37.120.245.83:26656,e281bdf052dad68ccf40777cb7d25649a5b9fa26@207.180.219.160:36656,3e085ac1382e57a62c770e11b334fb7a9a9c5daa@65.21.84.110:26656,f74e384e48bb78d566297eb502f8059798bfe2e5@135.181.16.163:26001,99ad87e4419cbea7c59b27e77442a457eda1dc21@65.21.202.61:25007,08cf0f37ca069d9f4027b0b6cb406c40c9fabb16@51.91.118.140:26656,bb9dc7bd893052ffae264ac7a9a4f440cf8dfd5b@121.78.247.252:22656,c32a8a97ded5c536f981cf922592f9a0ccf89e84@51.159.223.25:26656,233598946a15427b9541376e7cfc30dab07c4327@34.82.9.153:26656,00681773b1fb16749d750cc9aee6f5be28b7e143@84.203.117.234:26656,6483d2098cab9402c7931dc07181f42fbe3cc05f@148.251.177.108:14956,b7d0bd260fca7a5a19c7631b15f6068891faa60e@143.198.45.216:25001,c6bd4feba5ecfce5ee6f0ceda56066af098004a1@168.119.105.107:26101,abb2ddadc12f9135209d1dd03b3707f649ecbb7a@147.182.145.88:26656,328e0627172add338f6aed08600098a9308dc52d@147.182.145.103:26656,50bd49d6f0dd3bd5519572fc1522946c80702262@211.219.19.69:28656,a0071ec5e55a338f8098d8811f8b0d0a62c3be02@144.91.93.154:26656,531c7d39726c24b3262993fd22eff699e7b69801@82.223.161.222:26656,d13d77428697308eacb1a6a33b42f72650bc511e@80.64.208.139:26656,a2cfd24ca641a6d407b03d98595f4755b349df61@141.94.138.48:26676,ebd71b850b08d00145f5a85b8466ece5b1381f52@5.75.165.93:26101,86c9f2f5f252eee2b64cf0aec8059c86c88b8824@65.21.84.109:26656,f3208a4fc74c9f7326faabf2551d93d6e1fe69c2@222.106.187.13:40800,a53530c5bac43d5748e730f4f3abaa7b26d31ced@37.120.245.99:26656,08ec17e86dac67b9da70deb20177655495a55407@147.182.145.105:26656,d25ca51122f2bd7738001818eb39fd4919c8fe92@20.208.46.170:26656,a64c012c9312dec9b360400321f7377d1ad42987@95.216.137.166:26656,f7b4c3463b4c49c6d0029d415d5d097b4319cbb3@81.196.253.241:11656,f2520026fb9086f1b2f09e132d209cbe88064ec1@146.190.161.210:25003,5babe05a3251c1b230f4f42d3097aa6d2a3ec106@135.181.31.214:26656,18f9c04e865c39b54c168abeee6a6b7f88e4ae4c@35.238.39.142:26656,a4c679e745b6a24ab2c403631b2876e361f2377b@35.87.192.171:26656,ddb216793b9494c6a9cfcd1195111ef4238f3430@195.201.108.152:26959,d1752a3dcfc9d3169c47853a82fe0d1ec79c0024@147.182.145.100:26656,794fcb57bb76c50515f31dc8e0e8d6536dea859d@178.239.197.182:26656,053eac5b1ac089704225d59d2bc7b14a7f326e67@158.220.100.228:26656,29bc3833f3584eb795fc28653021cfa25d9bb9c6@82.100.58.103:30156,807f01c58ba88e59c97199498bd1189956178d8b@52.48.102.251:26656,c9940f4b6e6e90a992f729d9b4a21546ecc84927@3.248.201.150:26656,3d2516052fd8b134428971d1218a149bba6e44be@34.83.62.150:26656,8d7627c01a0f133495d123aeffef4a4db0cee254@89.250.150.241:26656,e0fa198c112258f18b8f580c07d509829caeeeda@159.223.95.19:10156,359d63178736911e3e4c716f2491cafaa687351a@35.197.1.194:26656,dab60f8d7f66e9a4c733c0bcfe145cfca6e331c2@209.182.237.121:28656"
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

