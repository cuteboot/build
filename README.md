# Prerequisites

You need:

* An Android device you'd like to "infect" :)
* A repo-checked out Android tree matching your target device well enough, i.e. same AOSP version/build
* A repo-checked out cuteboot manifest (see github.com/cuteboot/manifest)

## HW independent part

This should be done in your cuteboot tree.

* . build/cbenv.sh
* cb_select arm
* make -j14


## HW dependent part

This should be done in the Android tree.

* . build/envsetup.sh
* lunch (and select something suitable to your device (TBD: how?), e.g. aosp-arm-eng)
* pushd system/core
* patch -p1 < $CUTEBOOT_PATH/build/aosp-patches/aosp501-system-core-init-noselinux.patch (TBD: would be nice to script this)
* popd
* make -j14 libc libstlport liblog libz libm libdl libui libgui libutils libcutils libEGL libGLESv2 make_ext4fs init mkbootimg su

In same session, go back to cuteboot and:

* make hwdep
* make img

You get a fancy sparse cuteboot.img you can flash with fastboot cache


## boot.img modification

Grab a boot.img matching the currently installed software on the device.
This can be done on a rooted device with extraction of the boot partition
usually, or through factory image with a bit of luck.

Unpack it with build/split_bootimg.pl and note the name of the ramdisk.gz
* mkdir -p ramdisk
* cd ramdisk
* gzip -dc ../the-ramdisk.gz | cpio -idv

edit default.prop:

* make sure ro.secure=0
* make sure ro.debuggable=1
* switch ro.zygote to be =cuteboot  (so it doesn't try to start dalvik) 
* make sure ro.adb.secure=0 and is there
* add persist.sys.usb.config=mtp,adb

find any fstab files:

* make /cache partition mount on /usr instead
* make sure /usr doesn't have nosuid, or ro, or nodev

open init.rc:

* disable bootanimation service like this:

```
#service bootanim /system/bin/bootanimation
#    class core
#    user graphics
#    group graphics audio
#    disabled
#    oneshot
```

Copy $ANDROID_PRODUCT_OUT/root/init on top of init (this disables selinux which is a PITA)

re-make the ramdisk like this:

find . -print |cpio -H newc -o |gzip -9 > ../the-ramdisk.gz

and re-make the boot.img using the instructions split_bootimg.pl gave

## flashing the device

* fastboot oem unlock
* fastboot flash cache cuteboot.img
* fastboot boot boot.img 

## adb'ing in

* adb shell
* run /usr/bin/su to make sure you can get root privileges

## trying out cuteboot

* download http://qtl.me/minimer3.tar.gz
* untar it
* adb push minimer /usr/tmp
* adb shell

```
# /usr/bin/su
# cd /usr/tmp
# QT_QPA_GENERIC_PLUGINS=EvdevTouch QT_QPA_FONTDIR=/system/fonts LD_LIBRARY_PATH=/usr/lib:/system/lib:/vendor/lib QT_QPA_EGLFS_INTEGRATION=eglfs_surfaceflinger QT_QPA_EGLFS_HIDECURSOR=1 QT_QPA_EGLFS_DEBUG=1 QT_DEBUG_PLUGINS=1 /usr/lib/qt5/bin/qmlscene -platform eglfs main.qml
```

If you're lucky, you should now see a spinning blue image.

