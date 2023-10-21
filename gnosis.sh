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
sudo apt-get update && sudo apt-get install libsnappy-dev libc6-dev libc6 unzip -y

# Variables
PROJECT_FOLDER=gnosis
NETHERMIND_DOWNLOAD_URL=https://nethdev.blob.core.windows.net/builds/nethermind-1.21.0-bb9b72c0-linux-x64.zip
EXECUTION_FOLDER=execution
LIGHTHOUSE_DOWNLOAD_URL=https://github.com/sigp/lighthouse/releases/download/v4.5.0/lighthouse-v4.5.0-x86_64-unknown-linux-gnu-portable.tar.gz
CONSENSUS_FOLDER=consensus

sleep 2

echo "export PROJECT_FOLDER=${PROJECT_FOLDER}" >> $HOME/.bash_profile
echo "export NETHERMIND_DOWNLOAD_URL=${NETHERMIND_DOWNLOAD_URL}" >> $HOME/.bash_profile
echo "export EXECUTION_FOLDER=${EXECUTION_FOLDER}" >> $HOME/.bash_profile
echo "export LIGHTHOUSE_DOWNLOAD_URL=${LIGHTHOUSE_DOWNLOAD_URL}" >> $HOME/.bash_profile
echo "export CONSENSUS_FOLDER=${CONSENSUS_FOLDER}" >> $HOME/.bash_profile

source $HOME/.bash_profile

# Create folders
mkdir ${PROJECT_FOLDER} && cd ${PROJECT_FOLDER} &&
mkdir jwtsecret && mkdir ${EXECUTION_FOLDER} && mkdir ${CONSENSUS_FOLDER} &&
cd ${CONSENSUS_FOLDER} &&
mkdir data && mkdir keystores && mkdir validators &&
cd ..

# Create jwt secret
openssl rand -hex 32 | tr -d "\n" > "./jwtsecret/jwt.hex"

sleep 2

# Install Nethermind
wget $NETHERMIND_DOWNLOAD_URL
unzip nethermind-1.21.0-bb9b72c0-linux-x64.zip -d $EXECUTION_FOLDER

sleep 1

rm -rf nethermind-1.21.0-bb9b72c0-linux-x64.zip

sleep 1

# Create Nethermind service
sudo tee /etc/systemd/system/nethermind.service > /dev/null << EOF
[Unit]
Description=Execution Nethermind Gnosis Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$HOME/${PROJECT_FOLDER}/${EXECUTION_FOLDER}/Nethermind.Runner --config gnosis --JsonRpc.Enabled true --HealthChecks.Enabled true --HealthChecks.UIEnabled true --JsonRpc.EnginePort=8551 --JsonRpc.JwtSecretFile=../jwtsecret/jwt.hex
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sleep 1

sudo systemctl enable nethermind
sudo systemctl daemon-reload
sudo systemctl start nethermind

sleep 2

# Install Lighthouse
wget $LIGHTHOUSE_DOWNLOAD_URL
tar -xzvf lighthouse-v4.5.0-x86_64-unknown-linux-gnu-portable.tar.gz --directory $CONSENSUS_FOLDER

sleep 1

rm -rf lighthouse-v4.5.0-x86_64-unknown-linux-gnu-portable.tar.gz

sleep 1

# Create Lighthouse service
sudo tee /etc/systemd/system/lighthouse.service > /dev/null << EOF
[Unit]
Description=Consensus Lighthouse Gnosis Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$HOME/${PROJECT_FOLDER}/${CONSENSUS_FOLDER}/lighthouse --network gnosis beacon_node --datadir=data --http --execution-endpoint http://localhost:8551 --execution-jwt ../jwtsecret/jwt.hex --checkpoint-sync-url "https://checkpoint.gnosischain.com"
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sleep 1

sudo systemctl enable lighthouse
sudo systemctl daemon-reload
sudo systemctl start lighthouse

echo "70 installation_progress"

echo "export NODE_PROPERLY_INSTALLED=true" >> $HOME/.bash_profile

echo '=============== SETUP IS FINISHED ==================='
echo -e "\nCHECK OUT YOUR LOGS FOR EXECUTION CLIENT: \e[1m\e[32mjournalctl -fu nethermind -o cat\e[0m"
echo -e "\nCHECK OUT YOUR LOGS FOR CONSENSUS CLIENT: \e[1m\e[32mjournalctl -fu lighthouse -o cat\e[0m"
source $HOME/.bash_profile

rm -- "$0"