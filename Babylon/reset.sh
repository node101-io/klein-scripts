sudo systemctl stop babylond
sudo systemctl disable babylond
sudo rm /etc/systemd/system/babylon* -rf
sudo rm $(which babylond) -rf
sudo rm $HOME/.babylond* -rf
sudo rm $HOME/babylon -rf
sed -i '/BABYLON_/d' ~/.bash_profile