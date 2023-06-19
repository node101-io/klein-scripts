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


### Packages installations
sudo apt update # In case of permissions error, try running with sudo
sudo apt install -y unzip logrotate git jq sed wget curl coreutils systemd
# Create the temp dir for the installation
temp_folder=$(mktemp -d) && cd $temp_folder


### Configurations
go_package_url="https://go.dev/dl/go1.18.linux-amd64.tar.gz"
go_package_file_name=${go_package_url##*\/}
# Download GO
wget -q $go_package_url
# Unpack the GO installation file
sudo tar -C /usr/local -xzf $go_package_file_name
# Environment adjustments
echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.profile
echo "export PATH=\$PATH:\$(go env GOPATH)/bin" >>~/.profile
source ~/.profile


# Download the installation setup configuration
git clone https://github.com/K433QLtr6RA9ExEq/GHFkqmTzpdNLDd6T.git
cd GHFkqmTzpdNLDd6T/testnet-1
# Read the configuration from the file
# Note: you can take a look at the config file and verify configurations
source setup_config/setup_config.sh


echo "Lava config file path: $lava_config_folder"
mkdir -p $lavad_home_folder
mkdir -p $lava_config_folder
cp default_lavad_config_files/* $lava_config_folder

# Copy the genesis.json file to the Lava config folder
cp genesis_json/genesis.json $lava_config_folder/genesis.json

# Set and create the lavad binary path
lavad_binary_path="$HOME/go/bin/"
mkdir -p $lavad_binary_path
# Download the genesis binary to the lava path
wget https://lava-binary-upgrades.s3.amazonaws.com/testnet/v0.3.0/lavad
chmod +x lavad
# Lavad should now be accessible from PATH, to verify, try running
# In case it is not accessible, make sure $lavad_binary_path is part of PATH (you can refer to the "Go installation" section)
lavad --help # Make sure you can see the lavad binary help printed out


# Create systemd unit file with logrotate
echo "[Unit]
Description=Lava Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which lavad) start --home=$lavad_home_folder --p2p.seeds $seed_node
Restart=always
RestartSec=180
LimitNOFILE=infinity
LimitNPROC=infinity
[Install]
WantedBy=multi-user.target" >lavad.service
sudo mv lavad.service /lib/systemd/system/lavad.service


# Enable the lavad service so that it will start automatically when the system boots
sudo systemctl daemon-reload
sudo systemctl enable lavad.service
sudo systemctl restart systemd-journald
sudo systemctl start lavad

echo '=============== SETUP IS FINISHED ==================='
echo -e "CHECK OUT YOUR LOGS : \e[1m\e[32mjournalctl -fu ${EXECUTE} -o cat\e[0m"
echo -e "CHECK SYNC: \e[1m\e[32mcurl -s localhost:${PORT}657/status | jq .result.sync_info\e[0m"
source $HOME/.bash_profile
