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
PROJECT=osmosis
EXECUTE=osmosisd
CHAIN_ID=osmo-test-5
SYSTEM_FOLDER=.osmosisd
PROJECT_FOLDER=osmosis
VERSION="15.1.0-testnet"
REPO=https://github.com/osmosis-labs/osmosis.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/osmosis/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/osmosis/addrbook.json
PORT=26
DENOM=uosmo
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="ec7a9352ff878755044c3d4ed78ebd646cdb210b@138.201.59.93:29656,229c0f4de9fdc491941072a9ee52567a9d796105@162.55.245.144:5010,9e995521d27583f957c9f408b52f2443f60ecdc3@65.109.99.43:26656,11ae47d8860e16ff5e6b8294583ae930c0f6cc54@206.125.34.196:26656,e112a5c8279b3646d7ed553dd903ea5a95cf701b@65.109.117.208:2160,375089061f82ae351b259bc22d9162dc6f2b9e3a@95.216.101.38:26656,429ff50d691e085549ab668c28a8257791d94b45@65.108.232.134:38656,9180bf213a35fc0b9f0b3e9b29f9f5c23a697450@220.130.223.158:29856,f98be4ab0eb48ab495c183aa7c9a01751901a2f7@80.64.208.115:26656,0e6f924a3afe15996bc3f2612a9dd3bcf1c64212@222.106.187.14:53400,75ebdfb478c2ec89aab4b26039851265c2986a49@65.109.82.111:27656,5fad130bb23e0cdfc6e573b036b2e1dffc470de9@94.130.132.227:2000,7dd32b4e8d4202393e18305eb79819ad265bdc42@5.9.147.22:26256,a7fb76fd9fbbf1b7b8d06b16f1be4dccee41cacb@78.128.61.6:26621,c894735c31dae9a018ab284752bef58bf012155e@165.232.148.125:26656,59a71f94c64eb44af348c1b057b285b576582781@137.184.6.25:26656,a5d7d7f1591a99c29ae2cd652e8c4423228adcd5@15.235.115.54:26656,357a2c93c2fa1787b3628603b5f1d8a01efdb503@135.181.0.102:26656,86aae6e5d255be814b1b55db112dab221b393131@185.242.112.143:23956,df00ca3b085b8e2c9a248fb257dc43079eef8d8b@65.108.72.233:46656,aec1c70f6a73ab02828c9dcecf215c9fade24647@162.19.25.111:26656,d55869f46e073074cab843559b280758fc6cdd74@176.103.222.29:26656,bb30ab786837c53cc7396392a88830f04bb6c43d@176.103.222.169:26656,2d38733d22e574168d5fb99745c732e9a01c7d34@135.181.117.238:26656,bf1d24e69df6e699714e163595ef0b15e6ea14f6@185.136.167.89:26656,31ce9b77d9be9bcd66b753dc2631ff4c1b1afad4@176.103.222.167:26656,0e76e98e0824b8aa32d22aab1df7502744c639a7@164.92.122.254:26656,e90b2edaac1a82e3b127b2af42f2c8e387508cc0@65.108.206.118:61756,35345916a0f0f2dfb1a4d7c52eb898297887bc15@80.64.208.1:26656,e2675ef758d7af2910afac8cc5379281980db7c9@34.87.104.240:26656,e0417fa9ef26bbb8163eca7945445975a5daea04@137.184.177.151:26656,f05e8ca306b3c663272bd71ecd29b8cdff0a66be@176.9.245.154:26656,31bfbccc402f8c92a5649486633b177f907965af@65.108.199.120:45756,0ec2e2881be792bffac26265d5f4508d7b3aaf49@34.143.163.221:26656,8d2867a5efc9df9e10663eeccc71dcac8bf9fc5b@34.87.148.189:26656,7151dcc4c63e977139fdb407bec4c535bbc24d74@157.90.213.235:26658,cfc05eb8fee1384aa53306e49ee1ba2c27a2eb88@95.217.34.91:27656,6b7a2a07a2532b18662d668d6663add37b8a6468@65.108.126.49:30656,bcfa863ca81194a6ff16c83eb0c16d16e6c87583@65.109.106.169:26656,087c5f2a89c2aea0a9add3402c85c45ef0a3d32b@113.43.231.41:37656,e2b3e3a6fb5eadab50d493b375078b17d68cb172@176.9.48.38:10256,dbed950f93f0a30cec22c95f0ac958cc9ebeafd9@65.109.158.85:26656,7b398ab867b2083687c959aae692185bc2c184d4@34.136.141.149:26656,c9fcfe59511ee60c42d4dbb59ba5adf9b8e900d0@38.146.3.230:12556,0437fd695815a45310eaeb523b7477af5f891ca8@52.27.102.84:26656,fdecf1fdb393e2c026ba31f8dab1c37df58d2ee0@34.128.103.188:26656,f6c4f6911bf8b1ddd106eef403546095e571c4b7@54.187.94.155:26656,1849f040d7181945627c95c324a376b0f01b6b80@34.208.228.19:26656,fe81b035a039beedab27ccc41960961170578019@23.88.5.169:31656,f440c4980357d8b56db87ddd50f06bd551f1319a@5.78.98.19:26856,5eab5d756e30496f4e23a5fd626a2f9637442a3e@5.199.170.92:34756,9f560bf8c65d45194f87e832dfededbe9aed48b2@91.194.30.203:56656,397b8e9bff1c67ec19f8f43ac4365bc99710a191@65.109.155.212:26656,84846ddd8c5371e928b68583835a4b0aba58dc0b@35.89.154.162:26656,b08ecd73db19bdb21a826ef420906a5e3f494642@44.208.202.207:26656,e79d69600b2bae5c219ae9845c746251515fc2a0@142.93.175.50:26656,28989fdf4bd4eae82d92c63667f2edff34405fc1@65.109.158.84:26656,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@176.9.82.221:12556,89ae7895201961267bfb3c61cc82618c75a69f25@23.105.148.5:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:12556"

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

echo "85 installation_progress"

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

