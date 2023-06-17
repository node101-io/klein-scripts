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
SYSTEM_FOLDER=$HOME/.nibid
PROJECT_FOLDER="nibiru"
VERSION=v0.19.2
GO_VERSION=1.19.6
REPO="https://github.com/NibiruChain/nibiru.git"
GENESIS_FILE="https://raw.githubusercontent.com/Pa1amar/testnets/main/nibiru/nibiru-itn-1/genesis.json"
SEEDS="3f472746f46493309650e5a033076689996c8881@nibiru-testnet.rpc.kjnodes.com:39659,a431d3d1b451629a21799963d9eb10d83e261d2c@seed-1.itn-1.nibiru.fi:26656,6a78a2a5f19c93661a493ecbe69afc72b5c54117@seed-2.itn-1.nibiru.fi:26656"
PEERS="a1b96d1437fb82d3d77823ecbd565c6268f06e34@nibiru-testnet.nodejumper.io:27656,39cf8864b1f1655a007ece6c579b290a9132082b@65.109.143.6:26656,19f6588df6e489a3e512ebac805c5250cdc9fbb7@84.46.249.14:26656,4910f38f7543dc97a9cfd2e820931ea0b70e00da@135.181.215.116:25656,b9389bfc008335f55c4ee252795e9c2f5d1236ed@49.12.43.94:29656,0a64c3212b135ff92d9d26305e764da5b37dc006@109.123.243.158:26656,11c7655bc96c229a3d18ca3bbe7d8944ce645aab@89.117.59.191:26656,408bfd8b902a1e688c068dae1d247b7324dd240d@185.193.67.136:27656,2dce4b0844754b467ae40c9d6360ac51836fadca@135.181.221.186:29656,65a213efcad697afb5a1303c7fe5be4168d9520c@43.154.103.36:26656,4a7065cb42272653779f41e1a9e63911743e8185@31.220.85.198:26656,8e471a078b929944d3812c44e7babe06fb32b527@178.18.249.99:26656,1c7735c89d8afa3a3adb1353df8a34cd7dcc6f77@78.46.135.37:26656,fc1cac088cad21e1572b80731d2efdff9f09470f@38.242.142.67:26656,982b9b071070f70bf58c41c0ecc8547ff87ba477@81.0.218.96:26656,6bb413df2b72cc61860f1dc06c61d59a23f14e00@65.109.32.139:26656,091ef5d449922e6de2b42039505bbd1c06a3cdc6@194.163.139.34:26656,f8ddd8555ce6837fec0b64e28daa80851bd98723@148.251.43.226:21656,958281e2c828ab54c5c828557becbdad3f346ffb@65.109.87.135:35656,4ae091976ef83403cbbb55345a1af0a06f3ef524@144.76.101.41:26656,a74ec7c34c10f1b2bfe360e595c7242b1e06d888@47.242.41.172:26656,1006710e216396697caf72a561498d1da1f563b4@81.0.218.86:26656,4ae7eeab8b1ec28e9a71365984dbc7fbfbefbdfe@89.163.146.199:26656,c83d16ddab9e16f61e553583f1589b9d24b7e6ac@31.220.87.238:26656,7e65b9d88cbf392906dad41ce9adba774912d60e@185.209.230.187:26656,d0ce7b356e76298ea59aeb78397e9d84f0ed2480@31.220.88.180:26656,e1cb0df376c0f88169cb203b304d7cf26b87d1a3@149.102.158.241:26656,f6626088ab596483d36f44b62f409a35a31757d6@81.0.218.141:26666,9086ceeeb979a8a3f6372a20e61b4d91dce9885c@185.215.165.159:26656,91ad1995b05111c8f9c43cdc7f801bd202de082d@62.171.172.94:26656,ed635eb28d417674a5f551f088772367622e7c92@138.68.99.211:26656,0cbe6d28190e5fee5f41071a622861e378421d16@161.35.17.234:03656,bfa223fc563019d95885b5ef3113011eafea387f@66.94.108.92:26656,d39e7451f84c3918860954f66ce473cca70ab70e@209.250.242.119:26656,0f8ea9f1dacc680e7074e8019bae16b1e8979977@89.117.58.243:26656,d8653d56d8914e5a26d7ff2f2f930dc44d593e1e@38.242.232.142:26656,13cc216c7c2c29783fae084062f10c68f2999d83@91.229.245.201:26656,563b3993420bcbb7226ac1f50ce6cbf9497de1c8@66.94.101.5:26656,02b8386250919fd9b054504eb6dfcd7dd65b5781@65.21.249.114:26656,8d3454b59a677665616d6ad9ee657b02580c8e97@46.101.16.102:26656,4a70de4fffde46382e70250c06f744570ce72ef9@138.201.124.93:26656,1eceb9c1dde5b66693f48eb0830bc8781deee3f3@161.35.19.181:26656,5544f891f1d3676c57809f7d72dcccd2cd15279e@89.163.157.93:39656,7e791abaa171405b699f7a70faed4462212c9f5b@65.21.138.123:29656,3a5d2bd306d6a0b842e5b14dfd1fc5a1069b55d1@14.162.196.251:20156,59816aa7410a331e82014555ff40eb26e86fff44@161.97.166.136:26656,d3dedce485a38433a14faa5ee09e08b23e5e5a03@109.123.244.57:26656,ec225abef682fa50f987d0c71573ec69a5e6ad97@86.48.30.243:26656,62ac888bf5af9b3a3fc3b32400fc9108f81a24da@77.120.115.141:39656,24d4d29dd2780b30fdf5772b39d2103aa225342d@93.183.211.195:26656,5376d83843b4f52501c1e8929e68e1fc89a0c761@92.243.165.37:26656,a1b96d1437fb82d3d77823ecbd565c6268f06e34@nibiru-testnet.nodejumper.io:27656,e3bcf7faf6efca24f6d0735bc96f67929a8164d3@164.90.217.176:26656,19f6588df6e489a3e512ebac805c5250cdc9fbb7@84.46.249.14:26656,ad44af0e6a86f627583d5294d3a242dc2be733da@65.109.132.189:26656,f29c808ff578c7f3a3746b9b0b3e0504b3ee2315@65.108.216.139:26656,318ad438fa672303cb10c2c47e6270c70e46ff2b@207.180.247.228:29656,3edbefe333daf987dea52dd53e776add12483e70@193.203.15.44:26656,4a70de4fffde46382e70250c06f744570ce72ef9@138.201.124.93:26656,82117d7a759f92d8a8553646ccfb9208509b7aa8@84.46.248.21:26656,eef9734e501dcac0988585e2fc56d133653b1554@185.218.124.169:11656,6b8aca01c8ad5154ee9f00903a7d37bf4c744abf@178.18.252.136:26656,8e471a078b929944d3812c44e7babe06fb32b527@178.18.249.99:26656,a6e8e143f8ebe87b156ff21c9253bb6b8ade0a85@109.123.241.74:26656,bfa223fc563019d95885b5ef3113011eafea387f@66.94.108.92:26656,fc1cac088cad21e1572b80731d2efdff9f09470f@38.242.142.67:26656,107dd9dd2409de2868d9063dbbb643a15af09cbc@146.190.116.99:26656,e74f1204d65d0264547e2c2d917c23c39fcff774@95.217.107.96:36656,75e2f1fb85d2b951759f9d94f9706329c74f90e8@91.196.164.170:26656,4667ea254567c150b310ac41276ef92b42b45641@89.117.59.35:26656,d26e9d2a81ce80328d3a9aeabb0820fbc343b5f4@161.97.170.91:26656,d7ad256b785cb4acac8904db316f96ba708d55c9@217.76.49.78:26656,4ae091976ef83403cbbb55345a1af0a06f3ef524@144.76.101.41:26656,39a0aeea76f6e0fe498805603eff5820dccb2632@116.202.242.213:26878,c83d16ddab9e16f61e553583f1589b9d24b7e6ac@31.220.87.238:26656,ce3b71fc75fc5085e4a6234ce4de570113e1dca4@89.117.59.7:26656,91ad1995b05111c8f9c43cdc7f801bd202de082d@62.171.172.94:26656,ac75f67929dad1f77062c996126deb7270272eab@95.216.118.165:26656,d0ce7b356e76298ea59aeb78397e9d84f0ed2480@31.220.88.180:26656,13cc216c7c2c29783fae084062f10c68f2999d83@91.229.245.201:26656,d6b677f7608ce0a8c8d04a7db5f50bbd80437a4a@34.159.168.124:26656,563b3993420bcbb7226ac1f50ce6cbf9497de1c8@66.94.101.5:26656,db1deb2f4d23eb91da1d10e86562d84aaa0f9a0e@5.75.239.226:26656,4a7065cb42272653779f41e1a9e63911743e8185@31.220.85.198:26656,e7e1222d6394eb8b709c8d6c38e270b5e8788dc3@38.242.135.165:26656,0f8ea9f1dacc680e7074e8019bae16b1e8979977@89.117.58.243:26656,d8653d56d8914e5a26d7ff2f2f930dc44d593e1e@38.242.232.142:26656,07fd5bc75133c565c17351809abf4656f87d15f1@34.125.168.103:26656,06092c9a8d68640c189290abd7ee5da669865bad@31.220.90.83:26656,7e66e2984323a5c7de1967a6c7bd0931beb358da@89.117.62.163:26656,044a1330551029773a9dd25599ed7a02bbcdb42a@173.212.251.224:29656,73185c4494f0e7fb7c9742681f12f8b1d00cce6f@185.135.137.233:26656,c194911e6851257427511cef98343f4c34d0dd6d@167.235.255.244:27656,efd9203e9c44cb422f6d1bd0046fa458a93c989a@178.74.245.198:26656,b876e291e28df2cfaffda4f890506f498d93d169@167.235.137.180:26656,958281e2c828ab54c5c828557becbdad3f346ffb@65.109.87.135:35656,d39e7451f84c3918860954f66ce473cca70ab70e@209.250.242.119:26656,b6d1123aef9946afafd740315984e857f04e2ecc@75.119.139.114:29656,4cff1ff7146b85e9c14556dd0443d939a6510555@85.192.49.162:26656"
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

#Installation of GoLang

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"

echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version


sleep 1
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make install
nibid version # v0.19.2

$EXECUTE config keyring-backend test
$EXECUTE config chain-id $CHAIN_ID
$EXECUTE init "$MONIKER" --chain-id $CHAIN_ID

curl -s $ADDRBOOK > $HOME/.nibid/config/addrbook.json
wget $GENESIS_FILE -O $SYSTEM_FOLDER/config/genesis.json



#Set configuration settings

sed -i 's|seeds =.*|seeds = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/seeds)'"|g' $SYSTEM_FOLDER/config/config.toml
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.nibid/config/config.toml
#sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $SYSTEM_FOLDER/config/config.toml
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $SYSTEM_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $SYSTEM_FOLDER/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.nibid/config/app.toml

sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.025unibi\"/" $SYSTEM_FOLDER/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.nibid/config/config.toml

# sed -i 's|enable =.*|enable = true|g' $SYSTEM_FOLDER/config/config.toml
# sed -i 's|rpc_servers =.*|rpc_servers = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/rpc_servers)'"|g' $SYSTEM_FOLDER/config/config.toml
# sed -i 's|trust_height =.*|trust_height = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/trust_height)'"|g' $SYSTEM_FOLDER/config/config.toml
# sed -i 's|trust_hash =.*|trust_hash = "'$(curl -s https://networks.itn.nibiru.fi/$CHAIN_ID/trust_hash)'"|g' $SYSTEM_FOLDER/config/config.toml





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
curl "https://snapshots2-testnet.nodejumper.io/nibiru-testnet/${SNAP_NAME}" | lz4 -dc - | tar -xf - -C $HOME/.nibid


#state sync
STATE_SYNC_RPC=https://cascadia-testnet.rpc.kjnodes.com:443
STATE_SYNC_PEER=d5519e378247dfb61dfe90652d1fe3e2b3005a5b@cascadia-testnet.rpc.kjnodes.com:15556
LATEST_HEIGHT=$(curl -s $STATE_SYNC_RPC/block | jq -r .result.block.header.height)
SYNC_BLOCK_HEIGHT=$(($LATEST_HEIGHT - 1000))
SYNC_BLOCK_HASH=$(curl -s "$STATE_SYNC_RPC/block?height=$SYNC_BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i \
  -e "s|^enable *=.*|enable = true|" \
  -e "s|^rpc_servers *=.*|rpc_servers = \"$STATE_SYNC_RPC,$STATE_SYNC_RPC\"|" \
  -e "s|^trust_height *=.*|trust_height = $SYNC_BLOCK_HEIGHT|" \
  -e "s|^trust_hash *=.*|trust_hash = \"$SYNC_BLOCK_HASH\"|" \
  -e "s|^persistent_peers *=.*|persistent_peers = \"$STATE_SYNC_PEER\"|" \
  $HOME/.cascadiad/config/config.toml
mv $HOME/.cascadiad/priv_validator_state.json.backup $HOME/.cascadiad/data/priv_validator_state.json



sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile



