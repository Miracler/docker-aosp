#!/bin/bash
#
# Test script file that maps itself into a docker container and runs
#
# Example invocation:
#
# $ AOSP_VOL=$PWD/build ./build-marshmallow.sh
#
cpus=$(grep ^processor /proc/cpuinfo | wc -l)

repo init -u https://aosp.tuna.tsinghua.edu.cn/platform/manifest -b android-6.0.1_r81

# Use default sync '-j' value embedded in manifest file to be polite
repo sync

prebuilts/misc/linux-x86/ccache/ccache -M 10G

export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m"

source build/envsetup.sh
lunch aosp_arm-eng
make -j $cpus
