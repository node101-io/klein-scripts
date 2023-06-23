#! /bin/bash


go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

echo "export DAEMON_NAME=${EXECUTE}" >> $HOME/.bash_profile
echo "export DAEMON_HOME=${SYSTEM_FOLDER}" >> $HOME/.bash_profile
echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> $HOME/.bash_profile
echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> $HOME/.bash_profile
echo "export UNSAFE_SKIP_BACKUP=true" >> $HOME/.bash_profile

source $HOME/.bash_profile

mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin && mkdir -p $DAEMON_HOME/cosmovisor/upgrades

cp $HOME/go/bin/$DAEMON_NAME $DAEMON_HOME/cosmovisor/genesis/bin

cosmovisor init $HOME/go/bin/$DAEMON_NAME


sudo tee <<EOF >/dev/null /etc/systemd/system/$EXECUTE.service
[Unit]
Description=$EXECUTE
After=network-online.target

[Service]
User=$USER
ExecStart=$(which $EXECUTE) start --home $HOME/$SYSTEM_FOLDER
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_NAME=junod"
Environment="DAEMON_HOME=/home/<your-user>/.juno"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512" 

[Install]
WantedBy=multi-user.target
EOF

sudo -S systemctl daemon-reload

sudo -S systemctl enable cosmovisor

sudo systemctl start cosmovisor

sudo systemctl status cosmovisor

sudo journalctl -u cosmovisor -f
