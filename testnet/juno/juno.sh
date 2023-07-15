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
PROJECT=juno
EXECUTE=junod
CHAIN_ID=uni-6
SYSTEM_FOLDER=.juno
PROJECT_FOLDER=juno
RPC_URL=https://juno-testnet-rpc.polkachu.com
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/CosmosContracts/juno.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/juno/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/juno/addrbook.json
PORT=26
DENOM=ujunox
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="5e45800b3ca8197635eaa414d020847da7dd690b@63.225.118.133:36666,fe1ab509146465500aec5c9d0353eeeae5eb610d@65.109.70.45:25656,c92540b1331fbb8717410b78cb5c0d80b03f12c7@104.248.241.136:26656,467d26e0a2f600ba18d0d0132fa38a50b4bdeb81@65.108.44.149:11656,9fa783f86430b2caaeab3e371f23bf68cdf63f51@65.109.88.251:33656,5290450ed12efbf97ac267bce456957c64cb58e9@65.108.192.123:20656,84d97ac815b31e5700724ef55e04b12e204b1d5d@65.109.84.115:32656,000510b7c717906f59a65e200cafcaf91ec88fb1@135.181.59.182:24656,a671acf98bd0b20e334edd43b5e172af05b4c985@95.216.101.38:36656,eb4cbf9bfea70a9e02baffbe35df02f073c70049@65.109.92.241:1066,c89d41cc034aec6d6e0a68bf4d230b68b27fbb41@65.109.158.90:38656,5c5cdee8ba5baf98dadadeecfb8dcc72296a569c@65.108.226.183:12656,791875d0e15873a98657eac98c6ecace23c5c3b3@45.158.38.2:26656,36cc111d29e55baac237308f6650f181219eda1e@88.99.3.158:12656,9fcc9c577d6f74452fbf84aa6248a08cd257feec@144.76.117.105:26659,6f118b9992849fc90f3d2b651e328f54debdd7a3@157.90.135.245:2000,13451445247133c3882555f185693bdde841cae0@142.132.209.236:12656,39f3e9591b08fd2a67829dca825c8bef98e2a8f4@162.55.1.2:32656,9db06fae1998a14c79cb13d50152828b9fa049e9@185.16.38.149:26656,39b02285db6a2fe87aad8f17c70e68e037bedbde@185.252.235.216:26758,4a91597dfe3ec715bbf6def225066fbb6ad86cfe@207.180.204.112:36656,5adba84a219227d3cf6c2de163d49d6765538a3b@162.19.61.144:26656,3d934af6e80077063ff2505490d2130bb3b237c4@65.21.202.61:13007,4409f0d9b531abb41da1de9a7b1a80b553915462@204.93.241.110:27653,1e20dbd518660e58c4920b250c86d03b086ac5a6@66.94.108.167:26656,f559156a055d1f48aaeafb1e9d06f531a63c3a60@18.221.48.84:45704,c54bf418fb542634495f57a1e36c9bd057d55e1b@5.161.80.115:26656,7122dc770ae68c88b41ad11604eae490a5c02faa@38.146.3.201:12656,abfccd2f0935e07e3c3494f4ca2e6228e5779267@64.5.123.27:26656,c79bce8be3b2619d8f5bc6b72f86e790bc0143d4@104.149.137.90:26656,d2ed8285b5eaf6c496ae6013bdcb066982fe72e5@46.17.250.108:61156,f97d6ef0466cf6060462ad5a8f10796cc69e8d33@65.108.85.61:16656,4429f69d207b0970eb55f82ff5834fd519676cff@65.109.39.50:30656,6f05771e8e880b310d2f34e7697c36d78c7cfa6a@65.109.39.54:26656,60aba467cf6542af854d03dc3a7353ebe2c07a14@94.130.132.227:2100,1bcf021570bb0ddcd6724ad2854935a722a02a96@161.97.118.84:26656,ac9dd6db1d34c15b1de212b0c0c240615bfc2941@142.132.139.101:29656,a42879516f799380d4ec030a7b7cbfc5f4a306f5@162.55.245.144:2030,f10e6c7cdcc800580cecab36c2915d156f841310@75.119.149.106:26656,d0a439bd1a1303d023483663d319626d6c588690@80.254.8.54:26656,518d31bf039289b6c8d8defd7e9509d8e28b7cd3@93.190.141.68:1066,9f9abb4ace091f2305523fc5d63ce9bdb3494892@143.198.141.42:26656,28f625a64ae54617e0368bd4298c6a3c1e883d02@176.126.87.56:13656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:12656"

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

