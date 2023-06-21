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

# Update & upgrade
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt install -y curl git jq lz4 build-essential unzip ca-certificates gnupg lsb-release

# Download the Docker image
docker pull 5irechain/5ire-thunder-node:0.12


echo "Please select the type of node you want to run:"
echo "1. Full Node"
echo "2. Validator Node"
echo "3. Validator Node (Unsafe RPC Method)"

read -p "Enter the number of your choice: " node_choice

case $node_choice in
    1)
        docker run  -p 30333:30333  -p 9933:9933 -p 9944:9944 5irechain/5ire-thunder-node:0.12  --port 30333 --no-telemetry --name 5ire-thunder-archive --base-path /5ire/data --keystore-path /5ire/data   --node-key-file /5ire/secrets/node.key --chain /5ire/thunder-chain-spec.json --bootnodes /ip4/3.128.99.18/tcp/30333/p2p/12D3KooWSTawLxMkCoRMyzALFegVwp7YsNVJqh8D2p7pVJDqQLhm --pruning archive --ws-external --rpc-external --rpc-cors all
        ;;
    2)
        docker run -p 30333:30333 -p 9944:9944 -p 9933:9933 5irechain/5ire-thunder-node:0.12 --port 30333 --no-telemetry --name 5ire-thunder-validator --base-path /5ire/data --keystore-path /5ire/data --node-key-file /5ire/secrets/node.key --chain /5ire/thunder-chain-spec.json --bootnodes /ip4/3.128.99.18/tcp/30333/p2p/12D3KooWSTawLxMkCoRMyzALFegVwp7YsNVJqh8D2p7pVJDqQLhm --validator
        ;;
    3)
        docker run -p 30333:30333 -p 9944:9944 -p 9933:9933 5irechain/5ire-thunder-node:0.12 --port 30333 --no-telemetry --name 5ire-thunder-validator --base-path /5ire/data --keystore-path /5ire/data --node-key-file /5ire/secrets/node.key --chain /5ire/thunder-chain-spec.json --bootnodes /ip4/3.128.99.18/tcp/30333/p2p/12D3KooWSTawLxMkCoRMyzALFegVwp7YsNVJqh8D2p7pVJDqQLhm --validator --ws-external --rpc-external --rpc-cors  all --rpc-methods Unsafe
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose a valid option."
        ;;
esac
