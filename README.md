# cling-build
This repository contains build script for the C++ interpreter cling and publishes pre-built binaries of it.

## What Is Cling
[Cling](https://root.cern/cling/) is an incredible C++ interpreter ideal for fast prototyping. It is a part of [CERN Root Data Analysis Framework](https://root.cern/) project, which provides pre-built binaries [here](https://root.cern/download/cling/) but only for X86/64 machines. This repository provides binaries for ARM-based platforms built with chroot environment in [release](https://github.com/SdtElectronics/cling-build/releases). You can also clone the script and build it yourself.

## Usage 
Download release tarball and extract or clone build script and run. The cling executable will be at `release/bin/cling`. For more usage of the interpreter, run command `.help` in the prompt.

## Notes
* ### Build prerequisite:
	libxml2 cmake git python2 libffi (libffi-dev on Debian-based distros)

* ### Hardware to Run Manual build:
	LLVM is known for the extensive computing resources it takes to build it, and if you are working upon a QEMU, the cost will become even higher. It took about 5 hours and a half to build on my machine with a i5-8300h processor, enabling `-j4` for `make`. The reason for not enabling `-j8` is the spacial cost of building is high as well, which is prone to exhaust the memory with lots of threads enabled. Notice that the script enables `nproc` threads by default, and you may wish to pass an argument to limit it, e.g. `./build.sh 4`.

## Known Issues
It seems that cling would print characters not compatible with a serial console. In case you find problem using it on a device connected via a serial port, try out command below which executes cling within a wrapper:

```script -qc ./cling | cat```

## Credits
The build script is a modification based on [PKGBUILD of cling package in AUR by archibald869](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=cling) and [cling-all-in-one by Axel Naumann](https://github.com/Axel-Naumann/cling-all-in-one/blob/master/clone.sh).
