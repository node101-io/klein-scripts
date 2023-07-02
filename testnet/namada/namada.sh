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

#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop net-tools lsof -y < "/dev/null" && sudo apt-get update -y && sudo apt-get install wget liblz4-tool aria2 -y && sudo apt update && sudo apt upgrade -y && sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

bash_profile=$HOME/.bash_profile

if [ -f "$bash_profile" ]; then
	    . $HOME/.bash_profile
fi

if ss -tulpen | awk '{print $5}' | grep -q ":26657$" ; then
        echo -e "\e[31mInstallation is not possible, port 26657 already in use.\e[39m"
        exit
else
        echo ""
fi

EXECUTE=namadad
CHAIN_ID="public-testnet-10.3718993c3648"
NAMADA_VERSION=v0.17.5
REPO=https://github.com/anoma/namada.git
PROJECT_FOLDER=namada
HASH=v0.1.4-abciplus

rm -rf $HOME/.masp-params

if [ ! $MONIKER ]; then
	read -p "ENTER MONIKER NAME: " MONIKER
	echo 'export MONIKER='$MONIKER >> $HOME/.bash_profile
fi

swapfile() {
    grep -q "swapfile" /etc/fstab
    cd $HOME
    sudo fallocate -l 8G $HOME/swapfile
    sudo dd if=/dev/zero of=swapfile bs=1K count=8M
    sudo chmod 600 $HOME/swapfile
    sudo mkswap $HOME/swapfile
    sudo swapon $HOME/swapfile
    sudo swapon --show
    echo $HOME'/swapfile swap swap defaults 0 0' >> /etc/fstab
}
swapfile

echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile

sleep 1

cd $HOME
wget -O libssl1.1_1.1.1f-1ubuntu2_amd64.deb http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

# Rust installation
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

sleep 1

# Go installation
GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | sed 's/^go//')
wget -O go.tar.gz https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version

sleep 1

# Cometbft installation
COMETBFT_VERSION=v0.37.2
mkdir -p $HOME/cometbft_bin
cd $HOME/cometbft_bin
wget -O cometbft.tar.gz https://github.com/cometbft/cometbft/releases/download/${COMETBFT_VERSION}/cometbft_0.37.2_linux_amd64.tar.gz
tar xvf cometbft.tar.gz
sudo chmod +x cometbft
sudo mv ./cometbft /usr/local/bin/

git clone $REPO
cd $PROJECT_FOLDER 
git checkout $NAMADA_VERSION
make build-release
sudo mv target/release/$PROJECT_FOLDER /usr/local/bin/
sudo mv target/release/$PROJECT_FOLDER[c,n,w] /usr/local/bin/

cd $HOME && sudo rm -rf tendermint 
git clone https://github.com/heliaxdev/tendermint 
cd tendermint 
git checkout $HASH
make build
sudo mv build/tendermint /usr/local/bin/

cd $HOME
namada client utils join-network --chain-id $CHAIN_ID

sleep 3

echo "[Unit]
Description=$EXECUTE
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/.local/share/namada
Type=simple
ExecStart=/usr/local/bin/namada --base-dir=$HOME/.local/share/namada node ledger run
Environment=NAMADA_CMT_STDOUT=true
RemainAfterExit=no
Restart=always
RestartSec=5s
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/$EXECUTE.service
sudo mv $HOME/$EXECUTE.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

sleep 1

sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable $EXECUTE
sudo systemctl restart $EXECUTE

sleep 1

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mservice $EXECUTE status\e[0m"
source $HOME/.bash_profile
