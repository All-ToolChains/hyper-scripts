#!/bin/bash
# Copyright (C) 2015-2016 Hyper Toolchains
# This file is free software; Hyper Toolchains
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# List Toolchain script names.
scripts='arm-eabi-4.9 arm-eabi-5.x arm-eabi-6.x arm-eabi-7.x arm-linux-androideabi-4.9 arm-linux-androideabi-5.x'

# Build Toolchains
for exec in $scripts; do
  # Do not build Linaro variants for 7.x
  if ! [ "$exec" = "arm-eabi-7.x" ]; then
    $exec Linaro SaberMod;
    $exec Linaro Uber;
  fi;
  $exec SaberMod Linaro;
  $exec SaberMod Uber;
  $exec Uber Linaro;
  $exec Uber SaberMod;
done;

# State when complete.
echo '';
echo 'Complete!';
