#! /bin/bash
echo "#################################################################################"
date
sudo apt update -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool clang htop net-tools lsof aria2 -y
echo "#################################################################################"
echo
echo