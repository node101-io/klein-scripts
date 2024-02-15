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
PROJECT=hypersign
EXECUTE=hid-noded
CHAIN_ID=$(curl -s -L "${RPC_URL}/status?" | jq -r '.result.node_info.network')
SYSTEM_FOLDER=.hid-node
PROJECT_FOLDER=hid-node
RPC_URL=https://hypersign-testnet-rpc.polkachu.com
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/hypersign-protocol/hid-node.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/hypersign/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/hypersign/addrbook.json
PORT=26
DENOM=uhid
GO_VERSION="1.19"
PEERS="3506a956a2f90dde11c0d6174314eb5232f5786e@78.46.103.246:60756,e0fe2fd7aa53edabf4978d96928d4d754d2140b0@23.88.55.152:36656,df03fbd247164b104fe23871316f27d83b3aa56f@65.21.216.73:11456,a275d8018f683f279bf5167a72d294bfacafa839@178.63.102.172:41656,e7bb31c8fdd8d26a739bfd87cdf3ba7a8f90406e@65.21.145.228:31656,d5f7dfff307cefb8e960000caf53b92dd9c58a1d@65.109.28.177:29226,1acc83715399737cff74767e00807d1d402eb1e2@144.91.65.175:26656,41ec20c2d234415a0ed753b3694b27dcc9065967@65.109.82.112:13156,9dca393599154b9589777d4d050ac695e26ee010@65.109.95.104:32656,fdc0c02c25c3661e5cf52c68a2d4f8a24e692ce4@185.188.249.46:13156,9876d1b1e5b5968c1c729559325dd909f93c1d34@65.108.238.61:56656,2c0379f78b655e8a386cb477e3cf3cae700c4a7f@213.239.207.175:34656,3096d2f4fd2fab47ef04adfa3d762af23e08b3a2@38.242.248.2:26656,1de2abae74a4c5fd7d96d9869ef02187f81498f0@134.209.238.66:26656,5e4fc955b23ab00f6a07cb6d56e89aafac0c85ff@167.86.85.122:26656,77234414b2b057fa7201883316ea69490eb55a70@213.133.100.172:27161,c20f2216b56cb24921b688a6cffc7fe09799a069@162.55.103.44:26656,ec5127072c252f7246fb66f7e7762423a23ff6bd@154.12.228.93:31656,1ee5c144135e3f2d0a695beba26fd32430f06145@154.12.235.67:26656,91089c0911b59f59fe2ec79fdae017f9beefbbfd@65.108.101.158:26656,e9bf8e034cfb29658d252f81633ab91e9f28df26@65.109.89.5:27656,15d2f1bc2bfaa143388465ea115c59e5ce6e77dc@65.109.39.223:26656,b441c4bfa215e8b46fe058e7a4ce4886d87860e3@140.238.74.1:26656,bd2ae9f1c42183104719f7c44be078bb7d282a61@65.109.92.241:11056,aa8c0064e866dc57b341a389006df8925a0718fe@5.161.55.130:31656,c1b6d86f46eab9d0aa2e4399cddb9cf05d13621a@65.108.206.118:60556,4e08d5b0cb43c8d5ffc42987a5166bab2a04a93b@65.109.92.240:21066,52eee2c34150d621312087e49f118969472ba55f@149.102.137.192:26656,ed12770cba24bfc5ea73d470115067bde00d8291@162.19.237.155:26656,84408be4e3f13dcd976568d6370e1c50e9eb614d@185.252.232.110:46656,3b69fcc85294df7ab7bf050f37fc5c6073ae2983@89.58.59.75:60756,7ac746f53266043a92a05db06d1306b4e5f7e7c8@65.109.112.20:11014,bbbd2b6da27d29648b4a429885601d8a024633f8@46.166.172.249:26656,6851aa51b98acf9c1b235d2379edaaab504a91f2@23.121.249.57:26656,934324c3b4318d8438954d19a82673a3d218951b@142.132.209.236:10956,d92268c246e02a54103f7098b901b876c88f006e@5.161.130.108:26656,610843eda2f0388cb8e75917e8c1f63350bd3bd1@154.26.131.130:16656,83f1e2bfb86a2cf13870cff8f306cd0bc684e40e@194.163.158.209:26656,c395620698af314d68a62df4217f5fd1aacad696@65.21.129.95:24556,0c6758a3f4554bbc67da73993bbb697764c5c534@38.242.142.227:26656,fbc7ce82f02e24257395dc0310ad2921ea61e199@65.109.92.148:61156,55e8a3bc20328c23422e93d875db6dfd6d0adbf2@95.217.207.236:24556,23eff008c88dcc60ef9a71f2fb469c472679c35e@136.243.88.91:5040,ad06dd3131caea14bcbe809b5dc58c885859538e@144.76.201.43:26656,12a8e151b366a5cfe055440e6c2e44236b1c5a38@185.249.227.6:36656,d72875380d7b0b68f071623996bd5a86b7491287@116.202.227.117:31656,5c2a752c9b1952dbed075c56c600c3a79b58c395@185.16.39.158:26926,de1f980cc59bdb2457202768d4b4d964d783789e@167.235.21.165:36656,cf94099349980f9593a3f0362c85fe7c6eda8b14@8.219.48.59:26656,9875fa2b7e900dfbadd3f4fa5d872d13bb9684ff@65.109.154.182:37656,5b6356defbfc7227035698d6af7d686d3981a0eb@5.161.99.136:26656,e481047e3422ff5c79c174b65dc9852b8ed5af70@3.110.226.164:26656,2641ddcf28d8adf448edb573de1efba0b6971d9e@178.154.222.128:26656,7bd5ca4aebb21d664939295c306ad6aef70b5604@167.235.137.178:26656,e8d1141256790075e27cd4f9b3ee99f90fd4e3b9@130.255.170.126:60756,17befe8d02039c5b0f4489d22fcfe768cb35a035@209.145.53.163:10656,fd06a873c4172105925ed89e632ff3f369740eed@18.188.21.237:26656,efcb16ec33d8e6233d1068fff679c6fd64bf5802@65.108.225.158:10956,a3f3d6dba11bfe080693938666064b2324fbaccf@88.99.164.158:11056"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:10956"

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

#fast sync with snapshot
# wget -q -O - https://polkachu.com/testnets/${PROJECT}/snapshots > webpage.html
# SNAPSHOT=$(grep -o "https://snapshots.polkachu.com/testnet-snapshots/${PROJECT}/${PROJECT}_[0-9]*.tar.lz4" webpage.html | head -n 1)
SNAPSHOT=https://snapshots.kjnodes.com/hypersign-testnet/snapshot_latest.tar.lz4
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