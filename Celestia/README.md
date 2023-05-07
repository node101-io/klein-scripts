## Here's a quick guide for Celestia Network **mamaki** testnet.  Please feel free to use our guide and do not hasistate to reach us out for any needs. 

``` 
wget -O mocha.sh https://node101.io/celestia/testnet/mocha.sh && chmod +x mocha.sh && ./mocha.sh 
 
```
Create a validator

```
celestia-appd tx staking create-validator \
--amount=1000000utia \
--pubkey=$(celestia-appd tendermint show-validator) \
--moniker=<nodename> \
--chain-id=mocha \
--commission-rate=0.1 \
--commission-max-rate=0.2 \
--commission-max-change-rate=0.01 \
--min-self-delegation=1000000 \
--from=<yourwalletaddress> \
--keyring-backend=test \
--evm-address=$EVM \
--orchestrator-address=$ORCHESTRATOR_ADDRES \
--fees 1000utia \
--gas-adjustment=1.4 \
--gas=6000 \
-y
```

#### Don't forget to support us and our contents by subscribing to our channel!
#### 🐦 Follow us on Twitter ► https://twitter.com/node_101
#### 💛 Join our Telegram channel! ► https://t.me/node101
#### 🌐 Get detailed information about us by visiting our website! ► https://www.node101.io
#### 💼 Contact us on LinkedIn! ►https://www.linkedin.com/company/node101/
#### 🔗 You can find our links here ► https://linktr.ee/node101