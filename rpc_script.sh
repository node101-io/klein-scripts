#!/bin/bash
git clone https://github.com/CosmWasm/testnets.git

export EMAIL=hello@node101.io
export DOMAIN=desmos.node101.io
export RPC_URL=http://localhost:26657/

sed -i 's/.*rpc.DOMAIN.*/"'$DOMAIN'"/' $HOME/testnets/devops/endpoints/nginx/rpc.conf
sed -i 's/.*RPC_URL.*/"'$RPC_URL'"/' $HOME/testnets/devops/endpoints/nginx/rpc.conf

set -euo pipefail

apt install -y nginx certbot python3-certbot-nginx

echo n | certbot register --agree-tos -m ${EMAIL}
certbot certonly --nginx -n -d rpc.${DOMAIN}
certbot certonly --nginx -n -d lcd.${DOMAIN}

# process the variables in sites-enabled
for file in $(ls nginx | grep -v proxy); do
    FILE="HOME/testnets/devops/endpoints/nginx/${file}"
    sed -i s/rpc.DOMAIN/${DOMAIN}/g $FILE
    sed -i s,RPC_URL,${RPC_URL},g $FILE
done  

# copy over nginx configs
mv  $HOME/testnets/devops/endpoints/nginx/rpc.conf /etc/nginx/conf.d
mv  $HOME/testnets/devops/endpoints/nginx/proxy.conf /etc/nginx/conf.d

nginx -t
systemctl restart nginx




