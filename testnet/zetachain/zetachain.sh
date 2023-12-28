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
PROJECT=zetachain
EXECUTE=zetacored
RPC_URL=https://zetachain-testnet-rpc.itrocket.net
CHAIN_ID=$(curl -s -L "${RPC_URL}/status?" | jq -r '.result.node_info.network')
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/zeta-chain/node/releases/download/v${VERSION}/zetacored-linux-amd64
SYSTEM_FOLDER=.zetacored
PROJECT_FOLDER=zetacore
GENESIS_FILE=https://snapshots.kjnodes.com/zetachain-testnet/genesis.json
ADDRBOOK=https://snapshots.kjnodes.com/zetachain-testnet/addrbook.json
PORT=26
DENOM=azeta
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | grep '^go' | sed 's/^go//') 
PEERS="50457b5c44459f78687472916c894064cd778419@35.210.213.139:26656,0b4c08f5120721281526e78b2f6bc42c90ca5a88@43.249.37.157:31460,57693a9bce3ffb5d6023a161ac9f744ac09a2329@162.19.240.28:26656,d657cd8018104f796f1777b81cde621bf4489fa8@148.251.133.248:22556,a5573b26e1a0d50f6c067ceed6c067451a119c05@51.161.84.69:26656,4226fcb3b3809c00bc56283063fc52fa4bfc9a17@18.210.106.52:26656,6c3198c55a9cea202c97e33f54f0c08b8be698d8@35.210.29.235:26656,e3fea0450f9d23ad7b64d41aab882a82a0b71d6b@150.136.176.81:26656,87bd556702556b7850b7a42d387232796738eda6@131.153.154.161:26656,44d5afabfbc1d82a6788e6a8e910143a6fb57306@52.3.196.71:26656,c1bbbfe2a5b15674bf24a869b3e8189b6b410ae7@65.108.231.124:14656,39871a19628e2fff0512f92d9304942093559720@135.181.115.175:26656,8f53a5748f142bd16127b7b7cb1c79772b2ff3c5@131.153.202.63:26656,2505e8a3b49b7451ed58195c7015c5c677b18365@195.14.6.2:26656,a417c375685afb97b7210d4c101c835521572731@35.170.251.63:26656,0eeebc659a64452d2f21a059fd84bdbe2cfec2eb@89.58.18.245:31460,853c46d580fe0673aba2b72b4b93b9d156b882fb@52.42.64.63:26656,91efb62e89c49e933b530fc15a6b93468a395730@52.204.29.109:26656,0844caf1e7be0dc1ce1c0523e87140a3c79a1d77@148.251.177.108:22556,1d5d80e43477604fb857d3adb7201921f5dd7f0f@35.210.142.91:26656,ca9a79d73093b7f8582fc664066556c8aaa332d6@65.108.105.48:22556,68d47550f977c04e4457300b7f3277718b452b99@65.109.93.35:58656,683232bb3175d63fee1a5e43f2eab0b842a492cf@54.158.162.118:26656,038234610497601373b1d27e27251674c6c81df7@3.218.170.198:26656,e4f65c8c90148a81771f8e6b6c3f934891dbfe85@3.0.80.230:26656,541df90de74d9fe8a05812b7f12f68be11c5eccc@202.8.10.137:26656,50675ccd739eb9ba226ea429f8602a83db73f054@102.182.140.86:26656,9c26260b0148376d2343c4c8c2e2bd7f3f498cd4@35.162.231.114:26656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:16056,aef406aac7f49e47be377afa7c4a14c4e2fb9723@107.6.94.227:26656"
SEEDS="3f472746f46493309650e5a033076689996c8881@zetachain-testnet.rpc.kjnodes.com:16059"

if [[ $VERSION != v* ]]; then
  VERSION="v$VERSION"
fi

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

echo "20 installation_progress"

# Go installation
cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "30 installation_progress"

sleep 1

mkdir -p $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin
wget -O $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin/${EXECUTE} ${REPO}
chmod +x $HOME/${SYSTEM_FOLDER}/cosmovisor/genesis/bin/${EXECUTE}

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

echo "50 installation_progress"

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
SNAPSHOT=https://testnet-files.itrocket.net/zetachain/snap_zetachain.tar.lz4
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