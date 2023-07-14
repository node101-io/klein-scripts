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
EXECUTE=andromedad
CHAIN_ID=galileo-3
REPO=https://github.com/andromedaprotocol/andromedad.git
PROJECT_FOLDER=andromedad
SYSTEM_FOLDER=.andromedad
VERSION=galileo-3-v1.1.0-beta1
GENESIS_FILE=https://snapshots.kjnodes.com/andromeda-testnet/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/andromeda-testnet/addrbook.json
PORT=26
DENOM=uandr
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//') 
PEERS="e8d60ff778f3c27f54382ff22c7ac071f2a81027@35.223.36.227:26656,9264372934a9fb0b70852aaa0ce46a2fff478587@66.85.149.162:30656,bce4a3976c39d811d50b18ed104b0d04da398591@213.239.207.175:53656,baa7ae868ff2bd93e0467a679c81481dd517fb65@65.21.225.10:49656,857515ed6ab05e8e59f74e1050cb9e653e899cac@159.223.220.1:26656,c56bad24170d2a7fa4b6316cc08b2432cc0b0db1@5.78.80.25:26656,50fff25c44a764e50e83e08da7727fb2aa345101@65.109.93.58:40656,0ea6fb9170fb324f6862d040ccb33b282a7b1a63@85.10.193.142:26686,01adfd7bda8da0912146269464ba878c74620ce8@65.109.82.230:26656,c0e7e484e576f5aca635449a4ed41c2e7097103f@65.109.30.197:23656,0854b50137bbbcf63dd00bf4f3c2dab2bcdd8370@5.161.124.54:26656,900950a031cb758b761198e52b07fcc17616bd76@65.21.200.54:40656,20b4f9207cdc9d0310399f848f057621f7251846@222.106.187.14:53100,9a5b41ac06b3c131ca6e4959a465d6bc0d103e66@88.198.52.46:11556,72ff166996ef9590879a7b7ab00b3b71529632a9@65.109.90.171:31656,5e0d6bfea56f7da5a1bdf9e4d1ee95c672a9d957@185.144.99.13:26656,1171accc7427f2ffb76fcaa5acdef518ff42c382@178.63.104.200:45656,f6fd816c3b6e8350a03782059b1b934acbcebdb3@81.0.219.243:15656,294a03eabd098fe74ab1d5eac97d9fd11684d3db@120.226.39.215:26656,a92fc11278a35f66f8a79e94e4dc3d4471a9f588@139.180.191.116:26656,b9ba5ae75fbdee6812d1aa53ff7154ed59938cbc@57.128.151.101:26656,987a1359dfed5f538bd5ce54ba019a3eaedabee6@65.109.37.228:56656,ece6b901c278f91410b798edef805ba1d358c660@218.155.161.169:30273,f47f37481c972ae83ae99c8f4e0c81d1e45031ea@207.244.233.9:27656,fc59f8fc08a5dc9e37fc458b7fe56e900fc2cb6f@34.30.158.159:26656,31f08ac1a5c3d4bbb9d486e1ea96b298e04625df@65.109.84.33:40656,b6031525e988eefd03452807806f08b0e9bc3289@15.235.46.50:26656,5c2a752c9b1952dbed075c56c600c3a79b58c395@195.3.220.140:26946,8738dbddacf3f9e579cc6a33c38cd8e67844c579@217.76.49.110:26656,6b137e1df61936010ea30a354d8abd7010598e29@35.239.130.141:26656,447644c34095606449e8f7eb34eeea2d9b7f2216@65.109.225.25:26656,7e31ab391f5b5756a75dc18b5275b609c81a34ee@34.122.164.239:26656,432f3efc2f96308ac92bcbbae6daaf1b4c39a3e7@75.119.154.2:15656,453c95abab8d3e2d6a31f9a377f9f12cbe618c55@51.159.57.101:26656,346d791f15e87ec54676cde7379704beefadf048@65.108.105.99:31656,d1334258b592ebccb85a917aa65976b74e254a60@65.109.65.248:31656,0cf5d2bcc49c1acddb6b7b2bc547543ec2fbe844@34.239.246.206:26656,8b96338b18c1e4a76a119fe0812c131a4e2cc96a@65.109.70.45:20656,2854e7247155c5c0c418de40ed168850b4c73c60@85.232.252.19:26156,a03c1958163dc7d3035214b67bf4734801cd482a@138.201.204.5:50656,6d4f2faa284b9c9625e781309b637e92627b6afd@188.40.59.225:45656,be918740e3b2433caef4e4498c9ff7c76df98f29@144.76.201.43:26456,f7a7c6bf673c201c55ecf0d249df43826293d9d4@176.9.28.41:26656,4928b2aa3a2c89d2700d3ca1192455aefde74c3c@142.132.202.87:26656,84a3fb946d058646e995c95b76087ae010a38e72@1.55.7.109:15656,cfcd6c6b06203ef9e604cbd3f1410de100e03140@23.105.164.150:26656,bb5b725dfb5d2b667e8d0396b6ca5429af19ee4c@120.226.39.230:26656,8650338267af660914816765c438160e6c52190f@65.109.154.182:49656,f259ea40048744ccf6efcea92579a36a4b06035e@34.29.232.227:26656,8df8a64ecf0aaba1e1faee06d005aa912d578549@65.109.89.5:41656,08d583750fa4acadaf99eaae87dc1246f320cf8c@65.21.75.122:36656,db8d38295a1ac80d1d333106886984037ce05555@65.109.93.35:26656,124c2eaba28bac74c8d7128b923541b303b5241d@185.52.52.30:26656,38c0b1de2960590166fc7895360f82800b2114bd@65.108.238.61:24656,a985ecf6c6054d29b6e088e4434831497f7cc643@121.78.209.27:13056,a28c1d9745dc92641eddcdb3421c34d150eb1f80@120.226.39.231:26656,c8171d5b90ea72992408f8cfcd3893256d22aabc@65.109.94.221:40656,7786f708c1851dd433a03f71ec3ff74d65895de7@34.31.130.235:26656,516d2b79da2d49927e7638abde7011b765b965d3@65.109.100.209:26656,636f9eb34f533a2251e0a9bfb9c73744b08fdff1@31.132.165.22:26656,9e441c3d16d73b1c29081b75e0bc14131d1d2dc5@120.226.39.233:26656,280fe9d15d5399bdd549487246dac82bab0a3fe8@220.85.113.33:26656,161fa49c28d514b91919082ad2871e20d2a63db8@96.234.160.22:30556,11b8a381ff518ea175bbc96dd8e82716a30d04dc@116.202.227.117:15656,a8c07490f5aa649f5a17e0e7c3fcb93f144c6ed5@66.42.38.167:26656,28c405d93963c47825ccbb2e5af915f5351e8d71@88.99.3.158:11556,e40e240706e5c551de40fefab1ad9fbf4a4bec23@141.94.73.39:42656,4999706e72ccf925923fc3e65e94ea8cd0d6d584@65.108.206.118:26656,13dc844645671d5da8ee81ab969d19166c3df11d@65.109.90.169:15656,3ae657d661dbde3888b9aff2e7842adcd1b78154@148.251.177.108:11556,da7d8ff27d6aa891f54f0a6647dc0bd5ae1e7b49@116.203.35.46:46656,1413664d3cfa37c2d661f740b2b47105433f3872@65.21.139.155:34656,088157569b6a372da45b1f4384dcc6f346c5a9c9@167.235.115.119:26656,2b096acb7644899710adaad8d22c8784367c76d4@169.1.16.246:2010,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:15656,a98484ac9cb8235bd6a65cdf7648107e3d14dab4@116.202.231.58:15656,c857788f7ba773633c29b32f1f554d97f040c24c@46.17.250.108:61556,85c669e01f5fca4d1ef7636a9526296a0083bb1d@15.235.193.57:26656"
SEEDS="3f472746f46493309650e5a033076689996c8881@andromeda-testnet.rpc.kjnodes.com:14759"

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
sleep 1

# Prepare binaries for Cosmovisor
mkdir -p $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin
mv build/${EXECUTE} $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin/
rm -rf build

# Create application symlinks
sudo ln -s $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis $HOME/${SYSTEM_FOLDER}/cosmovisor/current -f
sudo ln -s $HOME/${SYSTEM_FOLDER}/cosmovisor/current/bin/${EXECUTE} /usr/local/bin/${EXECUTE} -f

# Download and install Cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0001$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

#fast sync with snapshot
SNAPSHOT=https://snapshots.kjnodes.com/andromeda-testnet/snapshot_latest.tar.lz4
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
