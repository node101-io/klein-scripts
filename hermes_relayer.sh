# For more detailed descriptions, refer to the https://github.com/informalsystems/hermes/blob/master/config.toml
# Which is an example config and has LOTS of comment lines.

curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"

git clone https://github.com/informalsystems/hermes.git
cd hermes
cargo build --release --bin hermes

cd $HOME
mkdir -p $HOME/.hermes/bin

mv $HOME/hermes/target/release/hermes $HOME/.hermes/bin/

echo "export PATH=$PATH:$HOME/.hermes/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

hermes version

## INSTALLATION PART OVER.

# THIS PART IS FOR CONFIGURING SERVICE FILE. 
sudo tee /etc/systemd/system/hermesd.service > /dev/null <<EOF
[Unit]
Description=HERMES
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which hermes) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF


#RELOAD, AS WE DO ALWAYS FOR EVERYTHING.
sudo systemctl daemon-reload
sudo systemctl enable hermesd


hermes config auto --output ~/.hermes/config.toml --chains <CHAIN_1> <CHAIN_2>

# RE-ARRANGE SYSTEM

# banksy-testnet-2  
# 07-tendermint-5, connection-1, channel-1, transfer, ------  IN ORDER, THEY'RE RELATED TO: client-id, connection-id,channel-id. Declare this channel for transferring tokens.

# osmo-test-5  ----- Same rules apply.
# 07-tendermint-83, connection-103, channel-88, transfer

tee $HOME/.hermes/config.toml > /dev/null <<EOF
[global]
log_level = 'debug'
[mode]
[mode.clients]
enabled = true
refresh = true
misbehaviour = true
[mode.connections]
enabled = false
[mode.channels]
enabled = false
[mode.packets]
enabled = true
clear_interval = 100
clear_on_start = true
tx_confirmation = false
auto_register_counterparty_payee = false
[rest] ## Probably for REST API
enabled = false
host = '127.0.0.1'
port = 3000
[telemetry] ## --- IT means measuring the distance, interestingly i can't see why it is used 
enabled = false
host = '127.0.0.1'
port = 3001


[[chains]]
id = 'osmo-test-5'
ccv_consumer_chain = false ## CCV is short for Cross-Chain Validation(2). 

rpc_addr = 'https://rpc.osmotest5.osmosis.zone:443'
grpc_addr = 'https://grpc.osmotest5.osmosis.zone:443'
event_source = { mode = 'push', url = 'ws://rpc.osmotest5.osmosis.zone/websocket', batch_delay = '500ms' } # LATENCY IS NECESSARY FOR HERMES. LATENCY = TIME_transaction - TIME_eventRecieved (3)
rpc_timeout = '10s'
trusted_node = false

# BELOW PARAMETERS ARE THE ONES THAT YOU KNOW VERY WELL I BELIEVE.

account_prefix = 'osmo'
key_name = 'OSMO_TEST_REL_WALLET'
store_prefix = 'ibc' # DECLARE THIS VARIABLES TO BE RELATED TO IBC.

default_gas = 800000
max_gas = 1600000
gas_price = { price = 0.025, denom = 'uosmo' }
gas_multiplier = 1.2

max_msg_num = 30 # MAXIMUM MESSAGE NUMBER, NECESSARY FOR KEEPING EVERYTHING UNDER CONTROL.
max_tx_size = 180000   # hermes default 2097152

clock_drift = '10s'
max_block_time = '30s'
trust_threshold = { numerator = '1', denominator = '3' }
address_type = { derivation = 'cosmos' }

memo_prefix = 'moniker' # MEMO IS PRINTED WHEN A RELAY OPERATION IS SUCCESFULLY DONE. IT HAS A DEFUALT VALUE, SO IT WORKS EVEN THOUGH YOU DON'T SET IT.
[chains.packet_filter]
policy = 'allow'
list = [
  ['transfer', 'channel-88'], # banksy-testnet-2 channel-1
]


[[chains]]
id = 'banksy-testnet-2'
ccv_consumer_chain = false

rpc_addr = 'https://rpc-t.composable.nodestake.top'
grpc_addr = 'https://grpc-t.composable.nodestake.top'
event_source = { mode = 'push', url = 'ws://rpc-t.composable.nodestake.top/websocket', batch_delay = '500ms' }

rpc_timeout = '10s'
trusted_node = false


account_prefix = 'banksy'
key_name = 'BANKSY_TEST_REL_WALLET'
store_prefix = 'ibc'

default_gas = 800000
max_gas = 1600000
gas_price = { price = 0.01, denom = 'upica' }
gas_multiplier = 1.2

max_msg_num = 30
max_tx_size = 180000

clock_drift = '10s'
max_block_time = '30s'
trust_threshold = { numerator = '1', denominator = '3' }
address_type = { derivation = 'cosmos' }

memo_prefix = 'moniker' # MEMO IS PRINTED WHEN A RELAY OPERATION IS SUCCESFULLY DONE. IT HAS A DEFUALT VALUE, SO IT WORKS EVEN THOUGH YOU DON'T SET IT.
[chains.packet_filter]
policy = 'allow'
list = [
  ['transfer', 'channel-1'], # osmosis channel-88
]

EOF



hermes config validate



read mnemonic && echo "$mnemonic" > $HOME/.hermes/BANKSY_TEST_REL_WALLET.txt
read mnemonic && echo "$mnemonic" > $HOME/.hermes/OSMO_TEST_REL_WALLET.txt

hermes keys add --key-name BANKSY_TEST_REL_WALLET --chain banksy-testnet-2 --mnemonic-file $HOME/.hermes/BANKSY_TEST_REL_WALLET.txt
hermes keys add --key-name OSMO_TEST_REL_WALLET   --chain osmo-test-5      --mnemonic-file $HOME/.hermes/OSMO_TEST_REL_WALLET.txt

rm -rf $HOME/.hermes/BANKSY_TEST_REL_WALLET.txt
rm -rf $HOME/.hermes/OSMO_TEST_REL_WALLET.txt

# https://faucet.osmotest5.osmosis.zone OSMOSIS TESTNET5 FAUCET 
# COMPOSABLE FAUCET ? MUST BE FOUND.

sudo systemctl start hermesd && journalctl -u hermesd -f -o cat

# UPDATING CLIENT. NEEDED TO BE DONE FOR BOTH CHAINS.
# hermes update client --host-chain banksy-testnet-2 --client 07-tendermint-5
# hermes update client --host-chain osmo-test-5 --client 07-tendermint-83


# ANOTHER EXAMPLE
# hermes update client --host-chain archway-1 --client 07-tendermint-2           







# EXAMPLE FOR SENDING TOKENS: 


# send from banksy to osmosis
# banksyd tx ibc-transfer transfer transfer channel-1 \
#  <osmo1_addr> \
#  11111upica \
#  --from=<banksy1_addr> \
#  --fees 5000upica


# send from osmosis to banksyd

# build osmosis binary (go 1.19 is required)
# cd $HOME
# git clone https://github.com/osmosis-labs/osmosis
# cd osmosis
# git checkout v15.1.2 # IMPORTANT : AUTOMATICALLY GET VERSION. get_version.sh CAN BE USED.
# make install

# recover osmosis addr 
# osmosisd keys add OSMO_TEST_REL_WALLET --recover

# sent tx
#osmosisd tx ibc-transfer transfer transfer channel-88 \
 # <banksy1_addr> \
 # 55555uosmo \
 # --from=<osmo1_addr> \
 # --fees 5000uosmo \
 # --chain-id osmo-test-5 \
 # --node https://rpc.osmotest5.osmosis.zone:443




# ft-transfer example from banksy to osmosis
#hermes tx ft-transfer \
#  --number-msgs 10 \
#  --key-name BANKSY_TEST_REL_WALLET \
# --receiver <osmo1_addr> \
#  --denom upica \
#  --timeout-seconds 30 \
#  --dst-chain osmo-test-5 \
#  --src-chain banksy-testnet-2 \
#  --src-port transfer \
#  --src-channel channel-1 \
#  --amount 7777











