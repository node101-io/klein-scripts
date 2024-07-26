#!/bin/bash

############ SET PROPERTIES #########

CHAIN_ID="chainid"
DAEMON_NAME="binaryname"
DENOM="denomination"
WALLET="wallet"
GAS_PRICE=0
DEFAULT_TOKEN_AMOUNT=1000000
TODAY=$(date +%d.%m.%Y)
MONITFILENAME="${TODAY}.json"

WALLET_ADDRESS=$(${DAEMON_NAME} keys show ${WALLET} -a)
VALIDATOR_ADDRESS=$(${DAEMON_NAME} keys show ${WALLET} --bech val -a)

mkdir -p /var/log/withdraw
############ AUTO DELEGATION #########
date &>> /var/log/withdraw/"$MONITFILENAME"
${DAEMON_NAME} tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --commission --from ${WALLET} --chain-id ${CHAIN_ID} --gas-adjustment 1.4 --gas auto --gas-prices ${GAS_PRICE}${DENOM} -y &>> /var/log/withdraw/"$MONITFILENAME"
echo "###################################################################" &>> /var/log/withdraw/"$MONITFILENAME"