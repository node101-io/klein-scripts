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

EXECUTE=lavad
CHAIN_ID=lava-testnet-1
SYSTEM_FOLDER=.lava
PROJECT_FOLDER=lava
VERSION=v0.8.1
REPO=https://github.com/lavanet/lava.git
GENESIS_FILE=https://snapshots.kjnodes.com/lava-testnet/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/lava-testnet/addrbook.json
PORT=26
DENOM=ulava
GO_VERSION="1.19.3"
PEERS="ef38861694f07881410c1b1c5852c72050831d68@95.214.55.74:26656,34271a6f82d755777a3db02be39e575bf4ebd415@65.109.30.197:28656,8f79bf6093fd728359f529a4a5214c0364749230@65.21.205.248:11656,ed295c3ece2ded17ea4007a680154db83abeca13@95.217.114.220:13656,ec8065014ed4814b12c884ed528b96f281104528@65.21.131.215:26686,1fd86f6ba06ef4b189276f97f70fea04161019db@144.76.176.154:11656,433be6210ad6350bebebad68ec50d3e0d90cb305@217.13.223.167:60856,149f9f017344ce9cebb637baa7cab57a28f3a8c3@86.111.48.159:26656,e4ebf07ed08ff8ee26a9a903d63ad34d1f59393e@95.217.35.186:56656,5e068fccd370b2f2e5ab4240a304323af6385f1f@172.93.110.154:27656,971ffed041f5b4d0d4fc474e86f0d19ce788d0f3@171.227.37.85:36656,47385d0a7051109de5342e3b27890c4a4b9e0763@65.108.72.233:16656,2a588e5ddcfd8c9095cc6f34b5b6966e31020cfd@65.21.123.172:11656,b1806dfabc9bb5fb721b3f82628a3fb23a2ad786@65.109.65.248:30656,3ec1ce800d88aed4fcf978b594439d64542c9e32@5.161.145.40:26656,c678ae0fd7b754615e55bba2589a86e60fc8d45c@136.243.88.91:7140,d3a466c4892943059b6b361e63eb0665ead5c574@147.135.222.170:55676,1ec38451f3e45535ceba905d1442310c69aaf93e@217.76.61.37:26656,ed780f77754e8c4657b145144f0f95225d43bb03@65.108.224.156:27656,71f6af45c867266f81d81193013fcb4137351355@194.163.155.84:56656,75ed1e87b48d6e1ab341e3568708c9fb81743ffa@65.109.88.251:11036,21eb46c44f46820e42cfe4afbe2f1104eef95cfc@135.181.221.186:30656,5600a9eed5fdf290229aacb21344398be81dd9c9@65.109.237.237:26656,24a2bb2d06343b0f74ed0a6dc1d409ce0d996451@188.40.98.169:27656,b591ef22e0c2082eb76dcac5ead95be55d01b695@65.109.178.147:26656,e3c92ba5f1ebd8bec0ab9431eb183ed9864eca87@65.108.231.238:46656,07c557b393b235a7b004a4a32831e54092dc24a0@91.107.147.250:26656,855ce67c043ed3f466b1cda61525193f6e239c93@144.217.201.173:26656,14ae45e7f2ff7491cfa686a8fcac7cc095bc38ff@213.239.217.52:39656,aebbf38433cc38ed3aad0bb5f2aa567797df78da@46.8.210.144:26756,5c107bb2b72c930a5ab3406a1f7c7345b7229b49@148.251.11.99:11656,0e0e01f932a124c45f7f8600e38dba445b5f5dc4@65.108.226.183:19956,c55e0f1c1916bfa35127ca194263fe65c75c2995@38.242.251.1:26656,07277038190e9eb8855a49b1a13d742d18d9bea5@65.108.41.172:26656,f22ea1e7b6d31966259e99177d714cffde27c4bf@152.32.211.182:26656,1377a4d43745a650fe21cc87641818854e9fbdcf@65.109.88.254:35656,147cf727f179eccbd29de3ebf5899c1f4a93f6de@46.38.235.53:26656,20c13bd0d972acba5588493fb528b558a0317013@38.242.133.203:26656,99327e5cf0f31ac3bb1ca8e39cc9f17c823b7ec1@109.236.88.8:26656,f0758765ef0350d5cbbdeebf0b8e84f76e21c46d@54.221.204.97:26656,d796c20b5bdb8f1633c2a13afbf12314a77b668c@91.107.148.113:26656,64df498c92b9ccaf78012229d399aa34a014f087@65.109.122.105:56659,b4d53b1e7a2fee2192a30e411ba83136c07ab595@161.97.147.107:26656,31478ee0c0521c7cfb3312b86ef490936b5ceb80@65.109.92.240:197,d64aa8f4d864daac54639cd1fdebbf4c464ba4f1@5.75.235.206:26656,c40a7bc3c7aee0428273c0bfa75fcb14bf0f44c4@65.109.90.171:30656,5585de73ef537dcbbe8ae04392ccea3a112cc6e6@65.109.85.170:49656"
SEEDS="3f472746f46493309650e5a033076689996c8881@lava-testnet.rpc.kjnodes.com:44659"

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

echo "5 installation_progress"

# Updates
sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop net-tools lsof -y < "/dev/null" && sudo apt-get update -y && sudo apt-get install wget liblz4-tool aria2 -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

echo "30 installation_progress"

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "50 installation_progress"

sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make build
sudo mv $HOME/$PROJECT_FOLDER/build/$EXECUTE /usr/local/bin/ || exit

sleep 1

$EXECUTE config chain-id $CHAIN_ID
$EXECUTE config keyring-backend test
$EXECUTE config node tcp://localhost:44657

$EXECUTE init $MONIKER --chain-id $CHAIN_ID

# Set peers and seeds
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml

echo "70 installation_progress"

# Set Config Pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$SYSTEM_FOLDER/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $NODE_HOME/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0ulava\"|" $HOME/.lava/config/app.toml

# Set ports
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:44658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:44657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:44060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:44656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":44660\"%" $HOME/.lava/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:44317\"%; s%^address = \":8080\"%address = \":44080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:44090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:44091\"%; s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:44545\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:44546\"%" $HOME/.lava/config/app.toml

# Download genesis and addrbook
curl -Ls $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json

$EXECUTE tendermint unsafe-reset-all --home $HOME/$SYSTEM_FOLDER --keep-addr-book

# Snapshot
curl -L https://snapshots.kjnodes.com/lava-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.lava

echo "85 installation_progress"

# Creating your systemd service
sudo tee <<EOF >/dev/null /etc/systemd/system/$EXECUTE.service
[Unit]
Description=$EXECUTE
After=network.target

[Service]
User=$USER
ExecStart=$(which $EXECUTE) start --home $HOME/$SYSTEM_FOLDER
Restart=on-failure
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.lava"
Environment="DAEMON_NAME=lavad"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile


