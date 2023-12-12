NEW_VERSION=
VERSION_NUMBER=

cd composable-centauri
git pull
git checkout $NEW_VERSION

# Build binaries
make build

# Prepare binaries for Cosmovisor
mkdir -p $HOME/.banksy/cosmovisor/upgrades/v${VERSION_NUMBER}/bin
mv bin/centaurid $HOME/.banksy/cosmovisor/upgrades/v${VERSION_NUMBER}/bin/
rm -rf build
