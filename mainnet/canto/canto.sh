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
PROJECT=canto
EXECUTE=cantod
CHAIN_ID=canto_7700-1
SYSTEM_FOLDER=.cantod
PROJECT_FOLDER=Canto
RPC_URL=https://canto-rpc.polkachu.com
VERSION='v'$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/Canto-Network/Canto.git
GENESIS_FILE=https://snapshots.polkachu.com/genesis/canto/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/addrbook/canto/addrbook.json
PORT=26
DENOM=acanto
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
PEERS="e6d62aa5215719eb1b7434e19bca4e7f62923ef4@65.108.106.172:58656,5401995b201605a03d9e1fd0460cbef49218bbf5@65.108.126.46:32656,78e7fb7977290f81a51ae636ed06ae1952d4263e@65.108.141.109:16656,491804f3447dabf6fae2e4b267a7ac86dae31145@116.202.36.240:10456,484e252942ffcc0c6e31278ac0f47a3ca1317aef@95.216.215.69:26656,3b25a50bf0fd8f5e776d2e17f4a0d75883bca7fb@65.108.227.42:26656,82956d94714ded8fd785acb498a0aeb7aafad7ff@85.17.6.142:26656,442312a34fc398e5890a4f7b04a705ab9a4cef53@65.108.238.103:15556,1d3ab5cc05452e29d8dafb4f96fcf3841c485287@51.210.223.185:35095,398f29340af10e160c7c6789675ef42e7f11385b@68.183.201.169:26656,ba7490bd7efb7eb579aaf3a809135754dd0da63c@35.209.236.8:26656,a441b9fec8006f28fb2add0517fa823b886834d6@5.79.79.80:35095,69c21a89c74d08cb4a3c463dc813fe279fe4f080@51.79.160.214:26656,d981cb4af3bdb5f3d356b004ef0eb0a459caa95c@146.190.136.204:26656,174f015f606fd1f139447158b81a1824f6352854@65.108.75.107:16656,1e575a8044920b2e847633b10193b4abceb8fd9b@176.9.28.62:26656,41caa4106f68977e3a5123e56f57934a2d34a1c1@95.214.55.227:27156,0eff7474968dcccad34e2c7d4d9aedf8afe8d89f@213.133.100.190:35095,894941dc55c5c4843e4ced9201b623df5c03742d@5.78.101.175:26656,58aa75a67f2550d6506304534ba2c08652e0a202@65.109.160.240:26656,6b9e3bc1f6605dcc4b7d79cd21853529429d05cb@54.205.227.206:26656,40aa5a817c845c3cb8c01d6b739dedd121f1691a@3.121.114.146:26656,ca040066c8e7896b6054f6bea1ccca8d46a0cf94@34.171.92.111:26656,f9f8f88dfde1bacca2f152089bb20c600dbb9d04@43.204.152.200:26656,cb7b2531c1fb7c2b3273bb139b284dce96f46dfc@34.65.10.108:26656,81fc7f83e9961790a279a1fbe3e2835cea032d0c@37.252.184.229:26656,f7ef948416e9744270da85775714fd076c9a9ed8@66.206.15.130:26656,a399361e6368104841796c3a3edf9770c02b52e9@202.61.228.78:26656,87d0375105122d9e7d3a534d55e5a9d8dd8a287c@71.236.119.108:12656,ed89cd0a87bcc3174bb81c2ab530298efdeba1c8@23.88.5.66:26656,67fff135659772b35b4ca43e76a4da06db3cee1d@165.232.129.65:26656,5ce67581ef51b30c70212a870f2e5ede27c31929@65.109.20.109:26656,a40576759a4d7c4c9c8ef4f01044479473effda4@34.102.13.49:26656,9cacae3a6f8551809e7d48affd6f5ef53416dbe1@65.109.140.145:26656,a93a2839d71a1a705c912163fcf3280e674c5647@204.93.241.110:27650,b77b142771865a7b99a6d06e46d2ec84079751b2@178.63.40.253:26656,bb80632a944c908a445cc391b98df58cb14d771f@139.177.206.110:26656,744294d2ecf5ddf14065be6d325e68dcbdf0c646@66.172.36.136:51656,2d4231b462ebe1daa54f164c83733c6027e80c91@142.132.203.177:40283,8641525995013a299651d40ae106e6ab7debc1d5@142.132.157.164:26656,cb154a6a7bed87077e1b8ade995610aa3eea9731@88.198.90.49:26656,806161e772260d8c39984845b215066f8526f557@51.178.65.203:26656,0ea8451a880b469be9f94a379dc2b63ea829d16a@208.91.106.29:26656,1f1ed172142fad58dd35bfa3502f4ee0cfbcdeb4@143.198.40.189:26656,42e5c9923c06e2100a19814c2fffbbdea641032d@15.235.114.194:10456,81f89cfa6dd6ec4cb2ee297e67dd4613657c4194@88.198.32.17:30656,ccfcf25072bef755dc571705262c4b00d77cffab@185.190.140.252:26656,f9fc759eb2fa4eb2159825cae149ba1065efa236@66.172.36.134:51656,add661a570b4db208f2b79a11e2788a37f1f20f0@65.109.83.24:26656,c1571ee332c022ff6c012f74b25f688e079fb8e7@38.242.201.41:26656,4ca0d25302e73bc715af543a28cb4212f9f67c31@176.9.24.121:26656,0d8a6aded4bd0243cc999d54a2d3dcdf5e34bf89@131.153.154.51:26656,a0a165866cf5408ed26459ff91e3968807fb13dd@148.113.142.18:26656,bf91ab66861955181d1ad71e92997936d22dba4d@131.153.142.33:26656,8692ff0c8c3fe0fee09441f3ef37874fb5e30bed@34.88.250.71:26656,f5e9676c41522ae7f9183a83e785b7df2bab692b@135.181.223.115:2540,ebd18bdf64ac9b8d0e38ab8706fcf9ee1d54e70a@95.217.35.186:60656,f8f34a4fda358ca8561d25e1e33636c97becbe7e@135.125.188.77:26656,a82dd5af60f21b69169bed1c1770fc4a4745758d@65.108.78.29:26656,b1f4e83318a81061754a6bddd4a49db1ba0999f5@178.18.242.173:26656,6103a94235ec3ddf4e177ae74fca7a63f65fd621@65.108.109.231:27656,7a3cbf930c2e58017af63e0b0c58f03273d23724@95.217.201.49:26656,c54a7212ce3a4e3746aa7d1b3f9ccad8c2763844@15.204.52.64:26656,12e4eee9220632f114b41c9aed5aeba15a33a8ae@143.198.228.162:26656,8121698737154f58e77f58a3053662e445793e7f@65.21.128.94:26656,6b90bb94063007ff88c14585debd84ababd7d637@65.108.79.198:26766,c6a2c0ed97f3a7c61073b758191d7375aad56163@34.67.27.129:26656,c49a3ee5068e8efc000337f6446992cc032719d3@13.213.0.156:26656,785c2f6f01a1976dd118cf1829f9e2018f3f2073@13.209.252.30:26656,2f409f9f45d18310c72f3cfab96e8da7e6a8162b@66.172.36.141:41656,fc17597511a7c42f4f59ae79eeba0b3e9f8e164d@207.180.215.221:26656,e92b6782d35822fc5965dc5b5e76ee383c0c5fc1@45.79.161.43:26656,dcaf8098663a18e72e104ee96b608c20b37dcbd6@152.67.72.84:26656,f3e0eaeef993aa2ed2610f84879dc99d93d7c933@159.89.52.46:26656,510e68d0b0ccb903663637547bf641961c4c9987@185.229.119.216:26656,2a369be7455ef7bb12a9e1a5e1ea1c198d9c38dc@66.172.36.135:51656,f15b2375cbfb2b9200096e311b8a1f703e7c2a68@149.102.153.162:26656,8fff39f1774a76baae20a49cbc59787f5aab31fe@70.34.217.207:26656,4214acf99da99f131d15d5106fa0ca4ec1251b27@65.109.34.212:26656,bb97d8bc8845acd63c7d4c094613ac497fc32385@45.77.116.198:26656,7bff3b9ff343b9004b62b4cdb6fadbbd14b1d6af@38.170.240.250:26656,3c6cfa876a3e90c75137fc1a3861f5cbe8ba047a@203.176.224.17:26656,fdd5c36d745058eeb36e8a523cdfa29d7a39fb17@149.202.91.235:26656,6ca9754e8ac8548262c325f918b48721645e8911@88.99.29.185:26656,acabacac1035aa397986dc4857df3e02c75af3b0@209.195.12.133:26678,ec623695c6dfaa265d9d7f5e3b058c51bca63f4f@65.108.124.219:27656,09697cfb424b2e3cc73350b6ed9cfd5e20f295a6@35.213.158.24:26656,90b8aa12eb6f4d02ae281445d2225979c1dd9023@173.42.99.242:26656,e9be148a8769fa588eb03d0b50905a4e33cf6ccc@35.76.185.2:26656,6ec7bd6bbe0bbf74103e8cdbac2c1c5b9176af2c@199.241.27.151:26656,90f9241f472993b1a2cf3eb33bf0852032f38bbf@185.197.250.236:26656,c600dd6f8e4f3836abeb957692d206708100322b@108.59.81.19:26656,b3c0f8a4e0c8ac480a08a45e8ebc66219222fe57@139.144.23.249:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:15556"

sleep 2

echo "export EXECUTE=${EXECUTE}" >> $HOME/.bash_profile
echo "export CHAIN_ID=${CHAIN_ID}" >> $HOME/.bash_profile
echo "export SYSTEM_FOLDER=${SYSTEM_FOLDER}" >> $HOME/.bash_profile
echo "export PROJECT_FOLDER=${PROJECT_FOLDER}" >> $HOME/.bash_profile
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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"1500000000000$DENOM\"/" $HOME/$SYSTEM_FOLDER/config/app.toml

sleep 3 

#fast sync with snapshot
wget -q -O - https://polkachu.com/tendermint_snapshots/${PROJECT} > webpage.html
SNAPSHOT=$(grep -o "https://snapshots.polkachu.com/snapshots/${PROJECT}/${PROJECT}_[0-9]*.tar.lz4" webpage.html | head -n 1)
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

