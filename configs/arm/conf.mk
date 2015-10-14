ARCH = arm
ANDROID_NDK = 9
ANDROID_API_LEVEL = 18
GCC_VERSION = 4.8
ANDROID_ABI = armeabi-v7a
ANDROID_BUILD_TOP ?= unknown
ANDROID_PRODUCT_OUT ?= unknown
TOOLCHAIN_PATH = $(PWD)/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8/bin
CROSS_COMPILE = $(PWD)/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8/bin/arm-linux-androideabi-
CUTEBOOT_CFLAGS = -Os -mthumb -Wno-psabi -march=armv7-a -mfloat-abi=softfp -mfpu=neon -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -DANDROID -Wa,--noexecstack -fno-builtin-memmove
CUTEBOOT_AUTOCONFIGURE = CFLAGS="--sysroot=$(PWD)/sysroot -g -pie -fPIE -Wl,-z,relro $(CUTEBOOT_CFLAGS) -I$(PWD)/sysroot/aosp/include -L$(PWD)/sysroot/aosp/lib" CXXFLAGS="--sysroot=$(PWD)/sysroot -g -pie -fPIE -Wl,-z,relro -I$(PWD)/sysroot/aosp/include -L$(PWD)/sysroot/aosp/lib $(CUTEBOOT_CFLAGS)" ./configure --host=arm-linux-androideabi --prefix=/usr
CUTEBOOT_AUTOCONFBUILD = $(MAKE) -C $@; $(MAKE) -C $@ install DESTDIR=$(PWD)/sysroot

include build/main.mk
