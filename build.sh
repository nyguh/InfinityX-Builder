
#!/bin/bash

# Prepare clean building folders directly in the root to save partition space
mkdir -p ~/android
cd ~/android

# Configure Git identities
git config --global user.name "nyguh"
git config --global user.email "afkbobobg@gmail.com"

# Initialize Project Infinity-X 3.10 with depth limits
repo init -u https://github.com/projectinfinity-x/manifest.git -b 16 --git-lfs --depth=1 --no-repo-verify

# Copy your custom munch map into the local engine
mkdir -p .repo/local_manifests
cp /tmp/macan.xml .repo/local_manifests/macan.xml

# Super-slim down sync parameters (Extracts files without keeping git log histories)
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --current-branch

# Set up terminal compilation commands
. build/envsetup.sh

# Select POCO F4 as our target phone
lunch infinity_macan-userdebug

# Bake the ROM!
mka bacon -j$(nproc --all)
