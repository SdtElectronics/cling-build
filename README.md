# cling-build
This repository contains build script for the C++ interpreter cling and publishes pre-built binaries of it.

## What Is Cling
[Cling](https://root.cern/cling/) is an incredible C++ interpreter ideal for fast prototyping. It is a part of [CERN Root Data Analysis Framework](https://root.cern/) project, which provides pre-built binaries [here](https://root.cern/download/cling/) but only for X86/64 machines. This repository provides binaries for ARM-based platforms built with chroot environment in [release](https://github.com/SdtElectronics/cling-build/releases). You can also clone the script and build it yourself.

## Known Issues
It seems that cling would print characters not compatible with a serial console. In case you find problem using it on a device connected via a serial port, try out command below which executes cling within a wrapper:
```script -qc ./cling | cat```

## Credits
The build script is a modification based on [PKGBUILD of cling package in AUR by archibald869](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=cling) and [cling-all-in-one by Axel Naumann](https://github.com/Axel-Naumann/cling-all-in-one/blob/master/clone.sh).
