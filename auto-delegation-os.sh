#!/bin/bash

############ SET PROPERTIES #########

CHAIN_ID="chainid"
DAEMON_NAME="binaryname"
DENOM="denomination"
WALLET="wallet"
PASSPHRASE="passphrase"
GAS_PRICE=0
DEFAULT_TOKEN_AMOUNT=1000000

WALLET_ADDRESS=$(echo ${PASSPHRASE} | ${DAEMON_NAME} keys show ${WALLET} -a)
VALIDATOR_ADDRESS=$(echo ${PASSPHRASE} | ${DAEMON_NAME} keys show ${WALLET} --bech val -a)

############ AUTO DELEGATION #########

while true; do
    # Withdraw rewards
    echo ${PASSPHRASE} | ${DAEMON_NAME} tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --commission --from ${WALLET} --chain-id ${CHAIN_ID} --gas-adjustment 1.4 --gas auto --gas-prices ${GAS_PRICE}${DENOM} -y

    sleep 120s

    # Get available tokens for delegation
    AVAILABLE_TOKEN_AMOUNT=$(echo ${PASSPHRASE} | ${DAEMON_NAME} q bank balances ${WALLET_ADDRESS} --output json | jq -r '.balances | map(select(.denom == "'"${DENOM}"'")) | .[].amount' | tr -cd [:digit:])
    AMOUNT_TO_BE_STAKED=$((${AVAILABLE_TOKEN_AMOUNT} - ${DEFAULT_TOKEN_AMOUNT}))

    # Delegate available tokens
    if [ ${AMOUNT_TO_BE_STAKED} -gt 0 ]; then
      echo ${PASSPHRASE} | ${DAEMON_NAME} tx staking delegate ${VALIDATOR_ADDRESS} ${AMOUNT_TO_BE_STAKED}${DENOM} --from ${WALLET} --chain-id ${CHAIN_ID} --gas-adjustment 1.4 --gas auto --gas-prices ${GAS_PRICE}${DENOM} -y
    fi

    date
    sleep 3600s
done