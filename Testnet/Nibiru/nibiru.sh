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

EXECUTE="nibid"
CHAIN_ID="nibiru-itn-1"
PORT=26
SYSTEM_FOLDER=.nibid
PROJECT_FOLDER="nibiru"
VERSION=v0.19.2
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
REPO="https://github.com/NibiruChain/nibiru.git"
GENESIS_FILE="https://raw.githubusercontent.com/Pa1amar/testnets/main/nibiru/nibiru-itn-1/genesis.json"
SEEDS="3f472746f46493309650e5a033076689996c8881@nibiru-testnet.rpc.kjnodes.com:39659,a431d3d1b451629a21799963d9eb10d83e261d2c@seed-1.itn-1.nibiru.fi:26656,6a78a2a5f19c93661a493ecbe69afc72b5c54117@seed-2.itn-1.nibiru.fi:26656"
PEERS=""
ADDRBOOK="https://snapshots2-testnet.nodejumper.io/nibiru-testnet/addrbook.json"
DENOM="unibi"

sleep 2
echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export CHAIN_ID=${CHAIN_ID}" >> $HOME/.bash_profile
echo "export PORT=${PORT}" >> $HOME/.bash_profile
echo "export SYSTEM_FOLDER=${SYSTEM_FOLDER}" >> $HOME/.bash_profile
echo "export PROJECT_FOLDER=${PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export VERSION=${VERSION}" >> $HOME/.bash_profile
echo "export GO_VERSION=${GO_VERSION}" >> $HOME/.bash_profile
echo "export REPO=${REPO}" >> $HOME/.bash_profile
echo "export GENESIS_FILE=${GENESIS_FILE}" >> $HOME/.bash_profile
echo "export SEEDS=${SEEDS}" >> $HOME/.bash_profile
echo "export PEERS=${PEERS}" >> $HOME/.bash_profile
echo "export ADDRBOOK=${ADDRBOOK}" >> $HOME/.bash_profile
echo "export DENOM=${DENOM}" >> $HOME/.bash_profile
source $HOME/.bash_profile

sleep 1

if [ ! $MONIKER ]; then
	read -p "ENTER MONIKER NAME: " MONIKER
	echo 'export MONIKER='$MONIKER >> $HOME/.bash_profile
fi


#Dependencies

cd $HOME
sudo apt update
sudo apt install lz4
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"

echo "10 installation_progress"

#Installation of GoLang

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"

echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "45 installation_progress"


sleep 1
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make install
nibid version # v0.19.2

$EXECUTE config keyring-backend test
$EXECUTE config chain-id $CHAIN_ID
$EXECUTE init "$MONIKER" --chain-id $CHAIN_ID

curl -s $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json
wget $GENESIS_FILE -O $SYSTEM_FOLDER/config/genesis.json



#Set configuration settings

sed -i 's|seeds =.*|seeds = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/seeds)'"|g' $SYSTEM_FOLDER/config/config.toml
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
#sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $SYSTEM_FOLDER/config/config.toml
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $SYSTEM_FOLDER/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/$SYSTEM_FOLDER/config/app.toml

sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.025unibi\"/" $SYSTEM_FOLDER/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/$SYSTEM_FOLDER/config/config.toml

# sed -i 's|enable =.*|enable = true|g' $SYSTEM_FOLDER/config/config.toml
# sed -i 's|rpc_servers =.*|rpc_servers = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/rpc_servers)'"|g' $SYSTEM_FOLDER/config/config.toml
# sed -i 's|trust_height =.*|trust_height = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/trust_height)'"|g' $SYSTEM_FOLDER/config/config.toml
# sed -i 's|trust_hash =.*|trust_hash = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/trust_hash)'"|g' $SYSTEM_FOLDER/config/config.toml

echo "70 installation_progress"

# Creating your systemd service
sudo tee /etc/systemd/system/nibid.service > /dev/null <<EOF
[Unit]
Description=NIBIRU Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which nibid) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

$EXECUTE tendermint unsafe-reset-all --home $SYSTEM_FOLDER --keep-addr-book

SNAP_NAME=$(curl -s https://snapshots2-testnet.nodejumper.io/nibiru-testnet/info.json | jq -r .fileName)
curl "https://snapshots2-testnet.nodejumper.io/nibiru-testnet/${SNAP_NAME}" | lz4 -dc - | tar -xf - -C $HOME/$SYSTEM_FOLDER


sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile
