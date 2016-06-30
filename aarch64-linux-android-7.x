#!/bin/bash
# Copyright (C) 2013-2016 The SaberMod Project
# Copyright (C) 2015-2016 UBERTC
# Copyright (C) 2015-2016 Hyper Toolchains
# This file is free software; Hyper Toolchains
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# Colorize build warnings, errors, and scripted prints
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
red=$(tput setaf 1) # red
grn=$(tput setaf 2) # green
blu=$(tput setaf 4) # blue
txtbld=$(tput bold) # Bold
bldred=${txtbld}$(tput setaf 1) # red
bldgrn=${txtbld}$(tput setaf 2) # green
bldblu=${txtbld}$(tput setaf 4) # blue
txtrst=$(tput sgr0) # Reset

cd ..
TOOLCHAIN1=$1
TOOLCHAIN2=$2
CPU=$3
FPU=$4
if [ "${TOOLCHAIN2}" = "Linaro" ]; then
BINUTILS=Linaro
else
BINUTILS=2.26
fi;
if [ -n "$CPU" ]; then
CPU="--with-tune=$CPU"
fi;
if [ -n "$FPU" ]; then
WITH_FPU="--with-fpu=$FPU"
fi;

if [ "${TOOLCHAIN1}" = "Linaro" ]; then
echo -e "${bldred}ERROR: Linaro does not have a GCC 7.0 source!${txtrst}"
fi;

echo ""
echo "${bldred}Preparing build system...${txtrst}"
echo ""

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
NUM_JOBS="$(cat /proc/cpuinfo | grep -c processor)";
MAKE_FLAGS=-j"$NUM_JOBS";

echo ""
echo "${bldgrn}Cleaning up files from previous compile...${txtrst}"
echo ""
cd build;
if [ -e Makefile ];
then
    make $MAKE_FLAGS clean &> /dev/null;
    make $MAKE_FLAGS distclean &> /dev/null;
fi;
TC_PATH=$DIR/out/${TOOLCHAIN1}-X-${TOOLCHAIN2}-aarch64-linux-android-7.x
PREFIX=--prefix=$TC_PATH;
if [ -d "$TC_PATH" ];
then
    rm -rf $TC_PATH;
    mkdir -p $TC_PATH;
else
    mkdir -p $TC_PATH;
fi;

# Android sysroot
SYSROOT_SRC_PATH=../sysroot/7.x/arch-arm64;
SYSROOT_DEST_PATH=$TC_PATH;
cp -R $SYSROOT_SRC_PATH -f $SYSROOT_DEST_PATH;
SYSROOT=--with-sysroot=$SYSROOT_DEST_PATH/arch-arm64;

# Build Configuration
./configure $PREFIX $SYSROOT --host=x86_64-linux-gnu --build=x86_64-linux-gnu --target=aarch64-linux-android --program-transform-name='s&^&aarch64-linux-android-&' --with-gcc-version=${TOOLCHAIN1}-7.x --with-pkgversion='Hyper-${TOOLCHAIN1}-X-${TOOLCHAIN2}-7.x' --with-binutils-version=$BINUTILS --with-gold-version=$BINUTILS --with-gmp-version=${TOOLCHAIN2} --with-mpfr-version=${TOOLCHAIN2} --with-mpc-version=${TOOLCHAIN2} --with-isl-version=${TOOLCHAIN2} --with-host-libstdcxx='-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' --with-gxx-include-dir=$SYSROOT_DEST_PATH/c++ --enable-initfini-array --enable-gnu-indirect-function --enable-gold=default --enable-threads --enable-multilib --with-libexpat --with-python --with-gnu-ld --with-gnu-as --disable-werror --disable-shared --disable-option-checking --disable-bootstrap --disable-libsanitizer --quiet --enable-plugins --enable-fix-cortex-a53-835769 $WITH_CPU $WITH_FPU $DISABLES;

echo ""
echo "${bldblu}Compiling your ${TOOLCHAIN1}-X-${TOOLCHAIN2} aarch64-linux-android-7.x Toolchain!${txtrst}"
echo ""
all1=$(date +%s.%N)
script -q $TC_PATH.log -c "make 1>/dev/null $MAKE_FLAGS";

echo ""
echo "${bldgrn}Installing Toolchain to:${txtrst}${blu} $TC_PATH ${txtrst}"
echo ""
make install &> /dev/null;

GCC_INSTALLED=$TC_PATH/bin/aarch64-linux-android-gcc;
if [ -e $GCC_INSTALLED ];
then
    rm -rf $SYSROOT_DEST_PATH/arch-arm;
    echo ""
    echo "${bldgrn}  _|_|_|  _|    _|    _|_|_|    _|_|_|  _|_|_|_|    _|_|_|    _|_|_|  _|${txtrst}"
    echo "${bldgrn}_|        _|    _|  _|        _|        _|        _|        _|        _|${txtrst}"
    echo "${bldgrn}  _|_|    _|    _|  _|        _|        _|_|_|      _|_|      _|_|    _|${txtrst}"
    echo "${bldgrn}      _|  _|    _|  _|        _|        _|              _|        _|    ${txtrst}"
    echo "${bldgrn}_|_|_|      _|_|      _|_|_|    _|_|_|  _|_|_|_|  _|_|_|    _|_|_|    _|${txtrst}"
    echo ""
    echo "${bldgrn}Your ${TOOLCHAIN1}-X-${TOOLCHAIN2} 7.x aarch64-linux-android-7.x Toolchain has compiled successfully! ${txtrst}"
    echo "${bldgrn}Toolchain is located at:${txtrst}${grn} $TC_PATH ${txtrst}"
    echo ""
    all2=$(date +%s.%N)
    echo "${bldgrn}Total elapsed time: ${txtrst}${grn}$(echo "($all2 - $all1) / 60"|bc ) minutes ($(echo "$all2 - $all1"|bc ) seconds) ${txtrst}"
    sleep 5
else
    echo ""
    echo "${bldred}_|_|_|_|  _|_|_|    _|_|_|      _|_|    _|_|_|  ${txtrst}"
    echo "${bldred}_|        _|    _|  _|    _|  _|    _|  _|    _|${txtrst}"
    echo "${bldred}_|_|_|    _|_|_|    _|_|_|    _|    _|  _|_|_|  ${txtrst}"
    echo "${bldred}_|        _|    _|  _|    _|  _|    _|  _|    _|${txtrst}"
    echo "${bldred}_|_|_|_|  _|    _|  _|    _|    _|_|    _|    _|${txtrst}"
    echo ""
    echo "${bldred}Error Log is found at:${txtrst}${red} $TC_PATH.log ${txtrst}"
    echo ""
    read -p "Press ENTER to Exit"
fi;
