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
PROJECT=evmos
EXECUTE=evmosd
CHAIN_ID=evmos_9000-4
SYSTEM_FOLDER=.evmosd
PROJECT_FOLDER=evmos
NET="testnet"
RPC_URL=https://raw.githubusercontent.com/ping-pub/explorer/master/chains/$NET/$PROJECT_FOLDER.json
declare -A versions
for url in $(curl -s -L $RPC_URL | jq -r '.rpc[]'); do
    version_tag=$(curl -s -L "${url}/abci_info?" | jq -r '.result.response.version')
    [[ -n $version_tag ]] && ((versions["$version_tag"]++))
done
VERSION=$(printf "%s\n" "${!versions[@]}" | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')
REPO=https://github.com/tharsis/evmos.git
GENESIS_FILE=https://snapshots.polkachu.com/testnet-genesis/evmos/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/testnet-addrbook/evmos/addrbook.json
PORT=26
DENOM=atevmos
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="8d25a2ebb16aa1877c6a37536401f240d248b879@208.91.104.36:26656,2b78bbd5767fa3caf18f536a1eaa3f09d9ae4743@65.21.237.194:26656,bfe9c72cf157afa5f9825c69511e0498ffc20e59@204.16.244.198:26656,81d580f9d75f5bb224d262f3d2960fb3a74d1f58@65.109.39.50:33656,035e832b5d57c20f6b8c7a88ef52b3b1610112f6@141.98.217.229:26656,88a4830e045d684e6cd8d805ddb3fde6c201236e@104.154.189.186:26656,44810707376b3b1f6c322dab3be44c5d3066f790@74.118.139.88:26656,f53a5d262d7f502894e8d19d179afe156eeb812b@35.206.155.207:26656,b7cd1af9540271e851890c0ac009e0039558addf@35.210.154.98:26656,383d6e02a1de5214055ddbd1fdbedcc967058b23@194.163.166.56:21656,64ce506634efb0479e4f810b599bf40bbd491b90@176.9.48.38:26676,9170ae94bccf39ddce3d7fbaef4f79d1d9585f5c@65.108.226.183:13456,3dafc7a873918e2f08ef8921259c68f74d0af433@65.108.75.107:27656,fc15ffa03f1a8e61f09fcb4209329ac791bec259@3.15.203.68:26656,a933529c47f50997c7b5473e3cefc2bab811d69a@144.217.74.11:27656,4e37e23c50fe52f7c57c61874c2469db0c77dfff@141.95.65.115:26656,4206d805c01fd7bf37638e9f924e430e311fba80@65.108.98.124:60226,75ffaf0850aad888cda8822969f42219800f5f6d@135.125.5.29:32656,bb2bc3731fff1295b04afa9c1a0997c46aab549d@69.164.215.43:26656,1c153d4dd2b711cd2410745163338528c6943660@141.98.219.35:26656,366bb843ad850e1a72f0f49cf347321c30d2a4de@108.209.102.187:26642,3f966003631f3639828ac7e3e9bc29c3a9e72c00@204.16.244.211:26656,2b2c154f38b5aae5cc0a8c599d213aab27ecc4f7@213.239.210.125:29356,a9113c2fff8170391bfdf8f6a4e395339486f7b2@108.209.99.67:26621,fbb95e9a88ca0d521fb6488f330a97cb54b5663c@95.217.38.250:26656,671a37d2ae89b81b013dc5549c9e6b68a199348c@198.244.203.181:26656,2c286be285bf6c053fea6b4db6ee8f18c0e0d4c3@162.62.133.148:26656,649234798458b493deece6a9e8ba1dc42b2c9f0f@65.108.238.61:22656,fd71c9507fd0ec5b4c85dc0274ec495e84e1ca1c@65.109.92.83:56659,b3015e2b206d5e742f759d9c0c82c09207346941@125.143.190.194:11002,397cc78184c84208584377250869495a7d00ff9c@220.130.223.158:31156,a23b8b61b259a92dd947ea58f7501e9af74df311@173.249.59.227:26656,84843eacb1d6fd01a02d8d3e24669193731db08a@148.251.8.22:26856,ee3410e220705b4942129ac960fe34360a6b01e7@212.232.29.237:26656,63f7807ed65ae8f12cd425aae7c2e55de94f0d6f@161.97.168.156:26656,554320b7f22c61e2e65ebcfc46840cb0c59e9871@142.132.198.157:26656,8cb6aa973e10ed8f2550308b16033c8c84333965@49.12.176.131:21756,48a480d2409fc88efd9fac59dd4f4a79866fe5f3@162.55.234.70:32656,33098ee0e6a5dab0eae6e5704be12037743792e5@162.19.238.151:26656,98e6f689a0278027bc89b3830cae3f0e96f31743@167.235.115.119:26656,d5a28d6bf5df2ab9c9bd6752e28607144389319c@74.118.139.89:26656,687d49b27204922bd4e728c2092e4ae2f7d93e9b@43.157.108.178:26656,b0f396c7211a68020dcbd4a9c140c8b12e276238@142.132.203.60:26656,7ff4a6acb3007481552d8f0ffc1bede9f1136090@65.108.129.165:26656,1601d5ca76ffa87cbf97e251dd63f21b90f003f5@65.108.71.92:32656,a0f233599d48a1671768ded37289cfa60ac9d32a@94.130.132.227:2010,b6d79086b1df2850b283df4de8d39dc1685de2d7@65.108.79.246:26664,2c17fb3cd97315b35e255c04ca75b6e418950fdb@188.40.127.38:26659,6aa9478e1c75d2824d35697160afd9bc3332a206@159.69.66.149:26667,41e7783e117d043aaf142ecb01cd126f4a899622@34.162.189.68:26656,4c9f3fb1dbc6f9b7b1a6b480ed95aff3f8006527@157.90.208.234:26676,3a6b22e1569d9f85e9e97d1d204a1c457d860926@35.210.59.73:26656,29e664686264ff54b34c9f4fb22c3f69568a749e@34.106.8.123:26656,ef05967176d21b3de1d7fc97c06200974af49867@34.71.160.136:26656,bde44e9dc771f608c3c6292098fd0d8aa2bbd41a@141.98.219.62:26656,62ea452aff9f585997203b952ecb5525dc9c9bd6@141.98.217.230:26656,f848f63d139abe26ff452c780e3cd0df6b699421@65.21.126.182:26656,f5883e7d027366def1401f1d5a30723b2bf424fb@34.145.224.61:26656,5c35090ac6eabf695750b33f084c5d8783cd3093@141.98.217.24:26656,2ad4a7ba24a5bdb4ae10e06733618f20d419de7f@141.98.219.61:26656,768354893dadab9e1c466b29fe858c9f58201eac@204.16.244.136:26656,94a1c3990a213cc18c2847bc186a599b29568935@74.118.140.25:26656,dbf32f33bb25f88632bab39951fd691a1623eab2@141.98.219.92:26656,4cc98b44ca109baef8dbad01313c968c0bcac3fe@167.235.117.93:29256,20bcc6392383270c1fb193511b9d2b1275289c70@222.106.187.14:54100"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:13456"

sleep 2

echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export CHAIN_ID=${CHAIN_ID}" >> $HOME/.bash_profile
echo "export SYSTEM_FOLDER=${SYSTEM_FOLDER}" >> $HOME/.bash_profile
echo "export PROJECT_FOLDER=${PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export NET=${NET}" >> $HOME/.bash_profile
echo "export RPC_URL=${RPC_URL}" >> $HOME/.bash_profile
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

