# ndk-box-kitchen

This repo is the kitchen used to create headers and Makefiles for building BusyBox with the command [`ndk-build`](https://developer.android.com/ndk/guides/ndk-build.html) in NDK. Scripts in this repo expect to run on Linux, however the generated code and Makefiles can be used on all NDK supported platforms.

## Usage

### Build :

- Clone repo:

```
https://github.com/YasserNull/ndk-box-kitchen
cd ndk-box-kitchen
```

- Build options :

Build without selinux

```
sh build.sh
```

Build with selinux

```
sh build.sh selinux
```

Or use run.sh:

`./run.sh generate` to generate required Makefiles and headers

`$NDK/ndk-build -j$(nproc)` to build the executables without selinux

`$NDK/ndk-build -j$(nproc) selinux` to build the executables with selinux

`./run.sh archive` to archive all built artifacts into `busybox.zip`
