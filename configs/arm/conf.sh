PATH=$PWD/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8/bin:$PATH
export PATH

PKG_CONFIG_SYSROOT_DIR=$PWD/sysroot
PKG_CONFIG_LIBDIR=$PWD/sysroot/usr/lib/pkgconfig:$PWD/sysroot/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR
export PKG_CONFIG_LIBDIR
