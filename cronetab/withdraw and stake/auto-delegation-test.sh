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

mkdir -p /var/log/delegate
############ AUTO DELEGATION #########

# Get available tokens for delegation
AVAILABLE_TOKEN_AMOUNT=$(${DAEMON_NAME} q bank balances ${WALLET_ADDRESS} --output json | jq -r '.balances | map(select(.denom == "'"${DENOM}"'")) | .[].amount' | tr -cd [:digit:])
AMOUNT_TO_BE_STAKED=$((${AVAILABLE_TOKEN_AMOUNT} - ${DEFAULT_TOKEN_AMOUNT}))

# Delegate available tokens
if [ ${AMOUNT_TO_BE_STAKED} -gt 0 ]; then
    date &>> /var/log/delegate/"$MONITFILENAME"
    ${DAEMON_NAME} tx staking delegate ${VALIDATOR_ADDRESS} ${AMOUNT_TO_BE_STAKED}${DENOM} --from ${WALLET} --chain-id ${CHAIN_ID} --gas-adjustment 1.4 --gas auto --gas-prices ${GAS_PRICE}${DENOM} -y  &>> /var/log/delegate/"$MONITFILENAME"
    echo "###################################################################" &>> /var/log/withdraw/"$MONITFILENAME"
elif [ ${AMOUNT_TO_BE_STAKED} -eq 0 ]; then
    date &>> /var/log/delegate/"$MONITFILENAME"
    echo "Amount to be staked is 0" &>> /var/log/delegate/"$MONITFILENAME"
    echo "###################################################################" &>> /var/log/withdraw/"$MONITFILENAME"
fi
