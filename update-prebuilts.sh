#!/bin/bash
# Copyright (C) 2015-2016 Hyper Toolchains
# This file is free software; Hyper Toolchains
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# List Toolchain directory names, seperated by version.
AE4='Linaro-X-SaberMod-arm-eabi-4.9 Linaro-X-Uber-arm-eabi-4.9 SaberMod-X-Linaro-arm-eabi-4.9 SaberMod-X-Uber-arm-eabi-4.9 Uber-X-Linaro-arm-eabi-4.9 Uber-X-SaberMod-arm-eabi-4.9'
AE5='Linaro-X-SaberMod-arm-eabi-5.x Linaro-X-Uber-arm-eabi-5.x SaberMod-X-Linaro-arm-eabi-5.x SaberMod-X-Uber-arm-eabi-5.x Uber-X-Linaro-arm-eabi-5.x Uber-X-SaberMod-arm-eabi-5.x'
AE6='Linaro-X-SaberMod-arm-eabi-6.x Linaro-X-Uber-arm-eabi-6.x SaberMod-X-Linaro-arm-eabi-6.x SaberMod-X-Uber-arm-eabi-6.x Uber-X-Linaro-arm-eabi-6.x Uber-X-SaberMod-arm-eabi-6.x'
AE7='SaberMod-X-Linaro-arm-eabi-7.x SaberMod-X-Uber-arm-eabi-7.x Uber-X-Linaro-arm-eabi-7.x Uber-X-SaberMod-arm-eabi-7.x'
ALA4='Linaro-X-SaberMod-arm-linux-androideabi-4.9 Linaro-X-Uber-arm-linux-androideabi-4.9 SaberMod-X-Linaro-arm-linux-androideabi-4.9 SaberMod-X-Uber-arm-linux-androideabi-4.9 Uber-X-Linaro-arm-linux-androideabi-4.9 Uber-X-SaberMod-arm-linux-androideabi-4.9'
ALA5='Linaro-X-SaberMod-arm-linux-androideabi-5.x Linaro-X-Uber-arm-linux-androideabi-5.x SaberMod-X-Linaro-arm-linux-androideabi-5.x SaberMod-X-Uber-arm-linux-androideabi-5.x Uber-X-Linaro-arm-linux-androideabi-5.x Uber-X-SaberMod-arm-linux-androideabi-5.x'

# Enter out directory
cd ../out
OUT=$(pwd)

# Push 4.9 arm-eabi Toolchains
for dir in $AE4; do
if [[ "$dir" = "Linaro-X-SaberMod"* ]]; then
branch=LxSM
elif [[ "$dir" = "Linaro-X-Uber"* ]]; then
branch=LxU
elif [[ "$dir" = "SaberMod-X-Linaro"* ]]; then
branch=SMxL
elif [[ "$dir" = "SaberMod-X-Uber"* ]]; then
branch=SMxU
elif [[ "$dir" = "Uber-X-Linaro"* ]]; then
branch=UxL
elif [[ "$dir" = "Uber-X-SaberMod"* ]]; then
branch=UxSM
fi;
cd $OUT/$dir;
git init && git add -A && git commit -m "New Build" -s && git checkout -b $branch && git push git@bitbucket.org:hyper-toolchains/arm-eabi-4.9.git $branch;
done;

# Push 5.x arm-eabi Toolchains
for dir in $AE5; do
if [[ "$dir" = "Linaro-X-SaberMod"* ]]; then
branch=LxSM
elif [[ "$dir" = "Linaro-X-Uber"* ]]; then
branch=LxU
elif [[ "$dir" = "SaberMod-X-Linaro"* ]]; then
branch=SMxL
elif [[ "$dir" = "SaberMod-X-Uber"* ]]; then
branch=SMxU
elif [[ "$dir" = "Uber-X-Linaro"* ]]; then
branch=UxL
elif [[ "$dir" = "Uber-X-SaberMod"* ]]; then
branch=UxSM
fi;
cd $OUT/$dir;
git init && git add -A && git commit -m "New Build" -s && git checkout -b $branch && git push git@bitbucket.org:hyper-toolchains/arm-eabi-5.x.git $branch;
done;

# Push 6.x arm-eabi Toolchains
for dir in $AE6; do
if [[ "$dir" = "Linaro-X-SaberMod"* ]]; then
branch=LxSM
elif [[ "$dir" = "Linaro-X-Uber"* ]]; then
branch=LxU
elif [[ "$dir" = "SaberMod-X-Linaro"* ]]; then
branch=SMxL
elif [[ "$dir" = "SaberMod-X-Uber"* ]]; then
branch=SMxU
elif [[ "$dir" = "Uber-X-Linaro"* ]]; then
branch=UxL
elif [[ "$dir" = "Uber-X-SaberMod"* ]]; then
branch=UxSM
fi;
cd $OUT/$dir;
git init && git add -A && git commit -m "New Build" -s && git checkout -b $branch && git push git@bitbucket.org:hyper-toolchains/arm-eabi-6.x.git $branch;
done;

# Push 7.x arm-eabi Toolchains
for dir in $AE7; do
if [[ "$dir" = "SaberMod-X-Linaro"* ]]; then
branch=SMxL
elif [[ "$dir" = "SaberMod-X-Uber"* ]]; then
branch=SMxU
elif [[ "$dir" = "Uber-X-Linaro"* ]]; then
branch=UxL
elif [[ "$dir" = "Uber-X-SaberMod"* ]]; then
branch=UxSM
fi;
cd $OUT/$dir;
git init && git add -A && git commit -m "New Build" -s && git checkout -b $branch && git push git@bitbucket.org:hyper-toolchains/arm-eabi-7.x.git $branch;
done;

# Push 4.9 arm-linux-androideabi Toolchains
for dir in $ALA4; do
if [[ "$dir" = "Linaro-X-SaberMod"* ]]; then
branch=LxSM
elif [[ "$dir" = "Linaro-X-Uber"* ]]; then
branch=LxU
elif [[ "$dir" = "SaberMod-X-Linaro"* ]]; then
branch=SMxL
elif [[ "$dir" = "SaberMod-X-Uber"* ]]; then
branch=SMxU
elif [[ "$dir" = "Uber-X-Linaro"* ]]; then
branch=UxL
elif [[ "$dir" = "Uber-X-SaberMod"* ]]; then
branch=UxSM
fi;
cd $OUT/$dir;
git init && git add -A && git commit -m "New Build" -s && git checkout -b $branch && git push git@bitbucket.org:hyper-toolchains/arm-linux-androideabi-4.9.git $branch;
done;

# Push 5.x arm-linux-androideabi Toolchains
for dir in $ALA5; do
if [[ "$dir" = "Linaro-X-SaberMod"* ]]; then
branch=LxSM
elif [[ "$dir" = "Linaro-X-Uber"* ]]; then
branch=LxU
elif [[ "$dir" = "SaberMod-X-Linaro"* ]]; then
branch=SMxL
elif [[ "$dir" = "SaberMod-X-Uber"* ]]; then
branch=SMxU
elif [[ "$dir" = "Uber-X-Linaro"* ]]; then
branch=UxL
elif [[ "$dir" = "Uber-X-SaberMod"* ]]; then
branch=UxSM
fi;
cd $OUT/$dir;
git init && git add -A && git commit -m "New Build" -s && git checkout -b $branch && git push git@bitbucket.org:hyper-toolchains/arm-linux-androideabi-5.x.git $branch;
done;
