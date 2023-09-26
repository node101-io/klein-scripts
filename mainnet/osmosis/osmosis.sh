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
PROJECT=osmosis
EXECUTE=osmosisd
RPC_URL=https://osmosis-rpc.polkachu.com
CHAIN_ID=$(curl -s -L "${RPC_URL}/status?" | jq -r '.result.node_info.network')
VERSION=$(curl -s -L "${RPC_URL}/abci_info?" | jq -r '.result.response.version')
REPO=https://github.com/osmosis-labs/osmosis.git
PROJECT_FOLDER=osmosis
SYSTEM_FOLDER=.osmosisd
GENESIS_FILE=https://snapshots.polkachu.com/genesis/osmosis/genesis.json
ADDRBOOK=https://snapshots.polkachu.com/addrbook/osmosis/addrbook.json
DENOM=uosmo
GO_VERSION="1.20"
PEERS="2f4c0337b2522034a614a5cb2c61a891fe753c03@5.9.81.187:29656,172ee5067b9b797a83a0d7d96ac6484ceb350757@95.216.150.74:26656,559167a59e5aeb881e5159455aafa2c2f4bb97fb@5.161.216.37:26656,9f2df25f380a7e67a92c3dc5e7c33c08555b30dc@5.9.108.19:26656,8c20d5d59287f2c28692cd39596abedb027aeec4@135.181.92.165:26656,50d934795b9d50374b44fc3c1764f6939722efc1@95.217.150.200:26656,d21d02eb8dfd32ea79e76d77d0b7ae86d1579d66@136.243.21.50:22656,4e30684305ede45f15c4ac8c74c04210a557c047@95.217.98.251:10301,89b6c99ecd215cbd7eeac7fe9636295600198621@176.9.158.219:41056,406f64a8d601e34d7311fd61ec87b0c7028bd230@138.201.23.39:46656,2def96b97cab65a6a35f871f0ab3c384a1176869@35.210.137.157:26656,8d14fccd836d69e35a0d113eb5fe20edbec30ff7@144.76.102.39:2000,29ecd1a65ce2c244ca90a1d190b3b8e58eed1ada@51.81.106.237:26656,b6b71d439dd5f65493adedb690843f3cd0570350@95.217.150.198:26656,3918d0e114ce819644e966141a5f5229d4248da8@135.181.138.95:2000,3b18921444cd9a5872cf4198d3a92015f45d35cc@136.243.72.31:38656,54d84c94180f13dbffa1b6855623c9262b5b9037@78.47.227.245:26656,b212d5740b2e11e54f56b072dc13b6134650cfb5@169.155.169.71:26656,ec21772235f3fe0bd4d0a88d2e900a2ddde6c23f@20.115.217.147:26656,9d2a0e58bb99ee650d2a92d76ea35afea3910454@116.202.224.210:56656,b09bf90af67e47827dc01e369d0f381979b06a54@193.34.212.220:26656,f95d9634ad68b8f0ac80ce308adb71d8c119ada5@141.98.219.104:26656,aef83c39c59bf601c2fb363e389ad4e406fbb814@65.108.232.248:27656,14e0863a9f4d63b213371efc4b80672ea60dcfc2@65.108.53.110:26656,e31ddff13ca9bdd3accdca5dd7e7e769d7787e21@116.202.238.233:26656,f024eadf265f72f4240e5e3ea20eac22f6695ccb@159.65.100.92:26656,97e4fe4ef5dc0615b485ae685f261f4300c42eb9@88.198.47.148:46656,13c9849cd1385796f3303e5fbcc26e9dcbddb502@15.235.43.188:26656,c257db7b3a7f61688c6452d1e9dcfb3034e54fe8@143.198.98.144:26656,6727a678e5d435ed8f372664a4210bb60ed53a31@13.213.56.178:26656,807eda3abecff79df294d127cf58d6d5e07393ee@67.209.54.21:26656,fe7873a8c6c4e2bda68a53c83d35fbf52016441c@185.119.118.110:2000,9021222169c169a1be821099a391a3968ff70e20@93.115.25.178:2000,42dc431302aa2ef924df3d9d2051d0cd7491d289@144.76.101.107:2000,da7994c3dc691b1f24aa3811a11d90c27683a307@66.206.15.130:26656,ac2fbcb5de633d136a942c28c3049e3edbc6e69a@85.239.233.61:2000,c51c7cf2855d3fbbc4319b3b5bc0ac394826a046@18.189.57.228:26656,e726816f42831689eab9378d5d577f1d06d25716@164.152.162.247:26656,1bb81ece9cb886f48b0415d42cea78fcf2076b4e@35.90.67.76:30556,776be570116404906277ddbba71ee3f5320479fd@15.204.212.175:26656,65f51ebf46256d829ae5903e9faf31dae35bdf46@95.217.98.249:10101,86268715a670b9e1f613f0622c5b573f512c349b@65.108.236.229:26656,91050cbd3da659fddd536c1323a695d22c729d34@103.180.28.206:26656,bf000c826f71d50f011470a9155ae81de32a9d54@13.213.13.228:26656,7c1202a3aee0f076d11df5f5df8d86b280779c08@95.217.98.250:10201,3d2efd13a1d6b7ebd780d5c21b9d2c493f75aa40@142.132.209.151:56656,e1b058e5cfa2b836ddaa496b10911da62dcf182e@169.155.168.234:26656,d334a0e7a5fba47ca0884d3f43d40794791fb357@54.255.63.188:26656,b9ce51b3c78c85da777fbefd2a1f3c0a281a38ff@65.109.152.49:26656,13832193ba6d478e53b3887fd0452dca9f494acc@147.182.231.31:26656,881aadec8fad5989a1bc1d808d747f2321a88c8c@139.59.57.13:26100,2ef2206bfa11c7d36bb6c06e3e94b27ac9bf7f6b@66.172.36.137:36656,1ca86f86db503c0a2ebee49371c0546aeeea9ab5@95.217.119.118:26656,d215dbe3293656f0e56898d868e86f86263b0b3a@15.204.47.112:26756,47987080e86e0b5dda26cd9be1c1677f00c46dcd@5.75.149.205:26656,0419c998d6aac0afdb05808ad9a935670248e209@65.108.204.56:26656,752f393a2720a27caaebc35b600997491e8f8702@65.21.196.250:36656,253bc0e57f48cb4f70493e6109b756208e20e8fe@135.181.171.121:26656,f1fe0a080d561d37a94bea6022cbc0972395a0f4@65.108.121.190:2000,e83c322769d616a7e94f71e01f303cdc00e37441@188.166.220.245:26656,1404ccdde6b1d38e07f4ade742367e60a5ecbed4@49.13.82.250:26656,f675ea45db21d722812296aaf6dd5a8cae2be12a@5.75.242.239:26656,4a837e3411b0281f00c07706cfea72d3ebc575f1@176.9.38.49:26656,67acaf16cfe0313688ff7cb563737497efde8015@46.4.91.49:29656,865df574150c29f108fdc96cad43ddcfe02ed2b5@49.13.62.125:26656,aaa024e39034b4c3900153e8c560e85c8c8cf70a@178.211.139.24:26656,2cb8dd6195c65458e3c18505bb70ce2ff624f85c@89.58.61.223:2000,7c67d9031b6ebb4372a77f02e486bd12d2a3b506@204.16.244.149:26656,6313d95a539368410b18da009d3c3248ba61362d@66.172.36.140:36656,74e8ba742d8312c250f3237c8c8f3f951c01f9df@95.216.4.104:26656,be0bf03a8b761a8bb969f3949e6040fd930b3d86@165.232.88.32:26100,aa8cd6f6d853ec3df2a6d074b287aa14ea54dd6b@170.64.216.189:26100,4bb3629e3dc67e59c2367f6baa1e12e79cbc7ab2@128.140.93.9:26656,22455ef5d0f5ba3869c4c471b33f6d686fb4de42@57.128.133.2:26656,31d2c86f7957e2db91297e54c3b0456ea06c2250@173.67.177.115:26656,0e4dabd06828145d5748f9bbc22860eafac8321e@65.109.86.210:26656,08ceabce6dadc0aa5d33dc2058b9eeeff6186116@142.132.248.253:27656,d0c050f33b7aa1032a3763da0e7eb8df0ac72a2c@162.55.92.114:12000,b0d2b883976f4fb8994d100e3adc85b9c4d22749@49.13.59.239:26656,ef30bc7dbac63eb868e66bad497368f2cd0924e1@141.98.217.102:26656,d4e6a9d74abbf4676c8fd2d58d27fc24b59056b9@143.198.22.206:26656,89757803f40da51678451735445ad40d5b15e059@169.155.44.27:26656,4c927f93d430baf31e6d6418e62c56f442f092bc@46.4.28.42:26656,25c562d758d7139b22f920317b80e215cf2f0c77@65.21.156.193:26656,5748e5e16aaef164c983164ae2757e18e58f21a4@65.21.122.120:26656,23a0f85a17f140f90a56b3e1c1cc7c2a58bc6ba2@128.199.144.199:26656,9203fbde463bd66bb451da3de390c7d3515c2bf2@65.108.46.248:26656,6b1dd134b30aeaeb2f21f33bd2cd0370a2275501@138.68.6.165:26656,35cfede71df74e48f0b2c6d12f51ccf17c39727b@95.217.98.254:10601,3243426ab56b67f794fa60a79cc7f11bc7aa752d@35.210.252.64:26656,8d62dfa437917bff46c18b650fab3cb7091554db@141.94.73.39:38656,2d171a8a939075665aec23a07fd51684f499d086@144.76.175.170:26756,a5ce326c6a5b78ef57d5121825e041a3cba94146@142.132.202.98:26656,663f79f1e646ed4a7b27f3f8ad7770323d76f06b@3.71.218.95:26656,6acef796262e3ba7d0a5c94d198f7089a04a4e90@5.75.243.228:26656,2ed369ba5939016f7e46d2c518bc2ac5a8b8c03d@144.76.102.37:2000,d6228417e917647022d7a6ae2cca8692645801a9@18.117.181.194:26656,b9129e4e9570226f42bd22936821dea00aab2aaa@46.166.143.68:26656,c05d67a5186caca8ea09170414a595d6581b3735@43.131.31.230:26656,e153cc49052d67280dfdd6d660f3d98622905850@209.133.193.74:26656,f225f8a168ec794d334d7100994b62e5e7648072@35.214.106.64:26656,27740d856eb1eab4580279365b858d1cb5459acd@65.109.93.152:38656,2f1ecfd274b892bd9bb12c8cd3e0b350e293a737@54.160.142.138:26656,ab4ea418db1c65c2517975988e2f35891637ff4a@185.111.159.235:2000,9e1698b35041778794d4cfa97c623d4239603c82@95.216.185.206:26656,7d0e0410ee66fc54ea4bd4aa6443ebb66ad77b97@168.119.106.234:26656,a50c8dcd0e83032b5e29d5c5beef6e54ddafb508@35.83.253.164:26656,7bb62afdc4adb147205e6888406aa66924ddc4df@95.217.150.236:26656,4c788a306dfe4ba082b911bc08520b50109e437a@95.217.150.201:26656,424135f4eeb1f31f471641f9bbb9f4e099c5341f@65.21.49.55:26656,27af00377d0d65f14ea8bcf7bc26a053f48ec58f@135.181.46.125:26656,4d659b7b244a68913bfbdc6c9e7aa1a64391238e@74.118.139.59:26656,f77426b7dd4f16f02920da052a5ff9de5aaca0e9@51.81.166.119:14100,d7a2b907c87c4f506f8da13a97f2d6dfe499952a@95.217.150.196:26656,1634c775e94f9acf1c0897f78c42790424f69f62@46.4.22.159:26656,ead74e3079b78902c1ba928ed5c9e8199e442ba2@95.217.150.199:26656,0b859e6004143ce8f629d636a5b2e53d681a72ec@88.198.35.12:56656,7c7558688e3bab9e1bc36da93deb2bfe3a9e48e1@95.217.150.197:26656,8df03c283680dd2ed139a6415a61bcbec5349b38@95.217.8.91:26656,6a776a925f2876514ac66bb79c343500f703c358@23.88.96.88:26656,7a31c2e871bca29ffc24fd43e6c0fd9e1df5f220@5.78.100.45:26656,14518696ba870cdf138aa0c699d9481f110ad0c9@78.46.251.151:26656,f0eae9784c5bcbfc94530ceb548e428470bb162b@54.177.235.99:26656,ae2e110ab256c915106546df955830d2e837ac69@164.90.145.230:26656,1c398af2208984d4e59bc41132e3eac0508abb0f@95.216.76.251:26656,3e35d14e36f4da4dcb3aa035091168a322ffa915@15.164.13.43:26656,b204bebd748c0741a57d0ac50fc5689f6ae68c94@35.77.218.227:26656,6d2769b070df0cdea85b0bd2c39235fc3b8eccc9@178.63.21.33:26656,c13125d0a7430de9448c97eea231e7dcab897df5@188.34.191.2:26756,77bb5fb9b6964d6e861e91c1d55cf82b67d838b5@35.212.77.47:26656,faf4f08d3b7f258d3f6962ec505ce111ce948ea7@35.214.76.192:26656,a72323512ddedf580affb0e0ba0bb32218ae8e6d@35.214.18.41:26656,569aac51b04607a18696c63035586816dec85511@157.90.213.235:26656,c293a777f62e3226ce9157940f29e587342926b8@95.217.98.252:10401,fc518fe67e6120b4e4896dacf66b96f1aee99383@65.109.32.148:26686,f3262b9f490720920b0002fadd500af1cef3e6a6@51.222.40.84:26656,4060aa514fc01b398420f0138ac0205b071d1fa0@46.166.172.247:26656,863203d1c2a9141ccff8b35591587c9f422ab497@95.217.176.95:26656"
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:12556"

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

cd $HOME
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
rm "go$GO_VERSION.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

echo "50 installation_progress"

sleep 1

cd $HOME
rm -rf $PROJECT_FOLDER
git clone $REPO
cd $PROJECT_FOLDER
git checkout $VERSION
make build
make install
sleep 1

echo "65 installation_progress"

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
$EXECUTE config node tcp://localhost:26657
$EXECUTE init $MONIKER --chain-id $CHAIN_ID

# Set peers and seeds
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$SYSTEM_FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $GENESIS_FILE > $HOME/$SYSTEM_FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$SYSTEM_FOLDER/config/addrbook.json

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

echo "75 installation_progress"

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
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:26657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile
