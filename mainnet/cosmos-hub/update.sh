NEW_VERSION=
VERSION_NUMBER=

cd cosmos
git pull
git checkout $NEW_VERSION

# Build binaries
make build

# Prepare binaries for Cosmovisor
mkdir -p $HOME/.gaia/cosmovisor/upgrades/v${VERSION_NUMBER}/bin
mv build/gaiad $HOME/.gaia/cosmovisor/upgrades/v${VERSION_NUMBER}/bin/
rm -rf build