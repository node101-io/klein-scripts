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
PROJECT=noria
EXECUTE=noriad
CHAIN_ID=oasis-3
SYSTEM_FOLDER=.noria
PROJECT_FOLDER=noria
RPC_URL=https://noria-testnet-rpc.polkachu.com
VERSION='v'$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/noria-net/noria.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/noria/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/noria/addrbook.json
PORT=26
DENOM=ucrd
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | grep '^go' | sed 's/^go//') 
PEERS="31df60c419e4e5ab122ca17d95419a654729cbb7@102.130.121.211:26656,b2b8e67a3158e0854570c7de61812c8c6e92e4bc@65.108.206.118:61656,4e119369ec024964daa81057f69577a90c63a7d5@65.109.70.45:12656,e41dc02e15d34a4be0eac1aad74450529af0ba48@185.246.86.199:5656,9ac65e3df9e40666ae598326f1882bbcf1be4685@65.109.224.214:26656,f6cafffa388af696513bd83be710f2dc5ba7eb68@95.217.4.62:36656,b55e2db9b3b63fde77462c4f5ce589252c5f45af@51.91.30.173:2009,0aa35e813c25c32419312e166a2a26ebb4dbef61@164.90.177.125:26656,f60568a6ed1f848857c1c6c113719c1bb687c656@65.108.105.48:22156,9e16c875dfce96fb492cf16c3221836eeaf71afc@65.21.82.203:56656,a9cec88d9913b8afc81cfbb0ffb78295bd9b2eb9@138.201.204.5:34656,42798554b12ff3c24107af3b47a28459d717bdf4@46.17.250.108:61356,839656c8fcbe32dd867b8b2acf926b2425040ff2@195.3.221.16:12056,ad749d0e0c6542b89b5f98dfafe05cb527d0b9fc@65.109.6.138:26656,725c9918c40ab15d4309f0dc38c0040d809babdf@65.108.233.102:33656,dcc47d4c13523d5c701198d30b38bb4d589c1083@65.108.211.139:26656,3c7d9d0fd067534f7abcd952eadfbd58bff83bde@86.32.71.164:26656,419438c7cb152a88a30d6922a2b2c7077dd4daf5@88.99.3.158:22156,a98484ac9cb8235bd6a65cdf7648107e3d14dab4@116.202.231.58:16156,73e5dc6e04a1dd28e5851191eb9dede07f0b38fb@141.94.99.87:14095,f3fdb6f7bbe514e3ca8b91ec03505a0cda317ae3@213.133.100.172:27060,c660bf910c013c1b603371cf4eb8ebee640000dd@37.252.184.249:26656,ad48efa062f11ec0edb79d4f9e8c9a78c26b05bd@188.40.106.246:60856,bdd10f1a5aea7595003879baa89043177af1a90f@142.132.248.253:65528,dae302f53ad526a9f0dd30baf327e98baca35de5@89.250.150.241:26656,200828e2327e57bc3729b9aac4cfe9bc7a139b30@65.109.95.104:27656,bb04cbb3b917efce76a8296a8411f211bad14352@159.203.5.100:26656,cf178ebf6570514221d49c79de8e40c4886a8383@159.65.242.64:16156,8336e98410c1c9b91ef86f13a3254a2b30a1a263@65.108.226.183:22156,846731f7097e684efdd6b9446d562228640e2b14@34.27.228.66:26656,a3a2a86740534e67c55774bf2b37299a8e268031@107.181.236.98:26656,c818c3aa14ae8183578b7be0572c2dcd75613e72@186.233.185.214:26656,adb152a90a61b910feb4b2cdbd3f897251aa5452@116.202.227.117:16156,5eedd8cf7fefc037a6233b1991c2a3b653518560@65.108.230.113:31066,e112124a8b01901e183390d40275d712e1570508@65.109.93.58:29656,c2ad9694928a3ef1aef2e7fea6b2ea2f95f544a8@159.203.22.146:26656,b3a4f9e9797a0ed73f3abc1eb02070212294b249@65.108.124.121:60756,7b074856fb87066e761e737f32b83734a3d290b6@128.140.56.206:46656,216e01ba9863a27bfe5aecc2ab4d301448a6c6e8@51.79.103.100:26656,0b6b896c1daf912857c16fa8d88d998dd0ef92d8@65.109.82.112:2966,dfcd861d57bf2fba4f308ffeae58803e3cd3c0f1@65.109.92.148:26656,0fbeb25dfdae849be87d96a32050741a77983b13@34.87.180.66:26656,29e4ff863fc4c382d53d8e9578a8b8011cf86190@45.85.250.108:26656,898d9295c4d22c392a28fa7a858d1d980e2df7ed@34.210.232.21:26656,4ee73649fbb5cb7c9789329758b7124a0f6c4ba1@154.38.166.159:26656,7111a00c1c257d252720f3e234beae8e6ead1baf@185.183.33.143:26659,0d27e318772deda62d7db08c31af657a8e6fa4ad@130.185.119.243:26656,5c2a752c9b1952dbed075c56c600c3a79b58c395@185.16.39.172:27316,afe93314d3d1f3b0bdc20f213983bd902263e171@18.188.137.12:26656,6f545a4ad86c2ce6a611295942e68bd024a24e89@65.109.155.238:34656,e3572371ea23ef0e7fb6abdde061c67cd51c3314@51.178.65.184:61656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:16156,06bea1e5ad267b8d88db3cd4ac617f48ddd9b166@65.108.199.206:33656,efe1e1f891f785e6541ad18ff228ea61894dd980@65.21.225.10:51656,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@176.9.82.221:22156"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:22156"

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
