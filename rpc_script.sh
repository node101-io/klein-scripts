git clone https://github.com/CosmWasm/testnets.git

export EMAIL=hello@node101.io
export DOMAIN=desmos.node101.io
export RPC_URL=http://localhost:26657/

sed -i 's/.*rpc.DOMAIN.*/"'$DOMAIN'"/' $HOME/testnets/devops/endpoints/nginx/rpc.conf
sed -i 's/.*RPC_URL.*/"'$RPC_URL'"/' $HOME/testnets/devops/endpoints/nginx/rpc.conf

mv  $HOME/testnets/devops/endpoints/nginx/rpc.conf /etc/systemd
mv  $HOME/testnets/devops/endpoints/nginx/proxy.conf /etc/systemd

bash $HOME/testnets/devops/endpoints/nginx.sh




