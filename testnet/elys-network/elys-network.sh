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
PROJECT=elys
EXECUTE=elysd
CHAIN_ID=elystestnet-1
SYSTEM_FOLDER=.elys
PROJECT_FOLDER=elys
RPC_URL=https://elys-testnet-rpc.polkachu.com
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/elys-network/elys.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/elys/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/elys/addrbook.json
PORT=26
DENOM=uelys
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | grep '^go' | sed 's/^go//') 
PEERS="a346d8325a9c3cd40e32236eb6de031d1a2d895e@95.217.107.96:26156,def2a9a89a7cf66e7e73f277384e6a66f82a68f4@95.214.55.138:13656,609c64cc50fb4ebbe7cae3347545d3950ea2c018@65.108.195.29:23656,734a87b41a015faf59a7d6266deea190421476c2@185.162.249.161:29656,9e456e22da0930be2761123b7036e386a3247647@57.128.110.141:26656,1cd3163afca4ad48949afdf6f18133fd3181e303@65.108.40.46:57656,40ec65e34f5800854c577bc9386ce82ed3fb4740@144.76.97.251:26656,8c23c1f060b69d9856d61d921038593deb5a969d@213.45.125.177:26656,d3235fc7392c1f789ce8d3176b44a378a110b99c@195.3.223.26:26656,0e0fe9abac3866e52d46ab03f6e10d271873cce9@65.21.232.160:21956,af58431c7bf3ce9cfc4f77f5243cc40e37454b50@65.109.154.182:40656,dc06b3547cf81c40c931a748679ce22161e5ac43@148.113.6.121:19656,03584e64595de9f78ea7c5d58bcb1a514f0eeaf3@89.58.16.33:15356,a98484ac9cb8235bd6a65cdf7648107e3d14dab4@116.202.231.58:15356,98143b5dca162ba726536d07a6af6500d3e6fe1e@65.108.200.40:38656,a42cc9d7134949ce2fa703c6e341a0bd9cc1984c@65.108.206.74:16656,3a69f577b14bb5e3829489881cc80841b785e092@116.203.129.0:26656,463805d557e309c599e25a1284c421919decec42@135.181.157.23:26656,ae29d8da169214e201c03789858b4228b56a004a@148.251.177.108:22056,d907ce9285951a2a063789df2f6bd4cc86b33d53@142.132.155.178:16656,cdf9ae8529aa00e6e6703b28f3dcfdd37e07b27c@37.187.154.66:26656,5c2a752c9b1952dbed075c56c600c3a79b58c395@178.211.139.77:27296,90ba88f45bae35ec15d51da7c2290df7d1890fc9@65.109.65.163:21956,00c65e06302fb35a1064d9aa4e528aaf98925aa8@65.108.105.48:22056,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:15356,3006864f8038bb7e965268b6db0de9ea9b9a711d@148.113.1.150:26656,8eaad55cb53a41262a98d76fd41c2ba4b7caf08c@185.169.252.221:26656,57094473fcaccc57602f4da8678042cadf5d85be@62.171.145.215:26666,8851667ffc0b35d3a993fce617fd7a1a736729ad@65.21.126.180:30656,70f45143c0c32f2dd640d70bfa5c99e20ac40acd@138.201.220.51:40356,0977dd5475e303c99b66eaacab53c8cc28e49b05@65.109.92.79:38656,3f30f68cb08e4dae5dd76c5ce77e6e1a15084346@167.235.21.165:56656,b904eb8b81f58608a2c4a086860fbd52d00ccba6@65.108.226.25:36656,d31b460f08532148e4b3bcffaf92a14d14c4f0b7@31.220.80.94:15356,79416b9dc2114b8246bf73aab6540bc55669a533@154.53.57.227:26656,b7b044df4dc2e709972b79c04d9eb7d921e3b45f@116.202.227.117:53656,88e3a50a3c553dcfde2c630cd4d2ebc87b951176@159.65.42.101:15356,ae22b82b1dc34fa0b1a64854168692310f562136@198.27.74.140:26656,f6480d5563172e7de0b97b666c4d503d7c4daae8@94.130.225.23:26656,1113dea9fa7bf9fee6441e365445209b88d5dc38@78.46.103.246:36656,f0e0dca090a5f2381c8b82d5709e3376a67b7790@185.246.86.199:6656,904df9ac27e2ed11eb72e31d0ad8dcc3caddae8c@65.109.82.112:2236,fb90efb77543ae9099b453df913c1ff4c595aec8@24.183.112.246:26656,729fb82fb1453ad54d40af39d0d54fe352069228@208.64.58.50:26656,8d9845f7ef934ade824981b9145a26f00192b575@45.79.24.206:26656,8458b882cd16e2e23c010103956a06e9370b246e@65.109.61.113:32140,bfcb384007647e50e02ab6a756deec9359c631dc@136.38.124.222:26636,a065d05a896c4a2e50451aa2994b1f37e95f92c2@195.3.220.169:26656,3a9b1d680bb392926c73e3c6c78d967c38d22e8f@95.216.7.136:12656,50a68a7a51a90735c2846ef68b508a62a3ed0127@116.202.223.95:26686,a4646e609eef009e0a6a527611e1b7af45cc8084@135.181.183.37:28656,ed81bcab745acc847a21a5f57ad7cdf3bbb232e8@74.50.73.38:26656,919929b0162de3c3a5a4b97d7971e043679912ea@65.108.72.253:38656,501767323c5223bfe138d916189cb5427f7e3931@104.193.254.42:27656,e8b4a9303c77d1c96ba2ecca28919619f9fa308e@95.216.102.235:38325,f3480371baafae419bfef68a64ace00dd8944bd6@65.109.92.241:10126,0e22ff4005e49a5d5c40c5c341f1d476448ee1e0@84.46.242.124:15356,18842ea01d32c76aa7d1668a734ffbac231f1fe6@65.108.6.185:26656,03785e3c3e4ef72dc85e93b2cd3a57c06a8e4cbf@165.232.89.253:15356,e61d49e8e6a1ecdb87cf7651a996b761ec9bc27b@88.99.79.217:15356,e27c08c6159ebe0fb6293336ee51e68c35fe2102@31.220.84.183:60756,8cc16cba9ccb2e1a555acb29bf53a9198ecae7ce@209.126.2.211:53656,1af9a47eae993ea84752fff373ec2c7eb27d5918@88.182.112.164:26656,917f122f053424b6916959e2907130bf7d302709@168.119.226.107:22356,7badd3d01c444317dbcecbb6ba845ad95f8eb9bb@169.0.53.93:26656,c90ec2d8e3094eede3fb0fb9f59e101269ae28b4@54.38.38.149:26656,ef61da20bb4f28bd68bfb97f18fe0f7f05de07fe@165.73.113.212:26656,61284a4d71cd3a33771640b42f40b2afda389a1e@5.101.138.254:26656,ae7191b2b922c6a59456588c3a262df518b0d130@65.108.231.124:38656,8723618f5dff7ac9b57472f90f2e86a2eb194e0a@71.236.119.108:25656,57837a87ad3169f3248fd267567d5f30f16d9504@173.212.243.149:15356,701a382e03978c54f1176145460125516b6a4672@3.144.113.232:26656,258f523c96efde50d5fe0a9faeea8a3e83be22ca@173.249.24.244:20273"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:22056"

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