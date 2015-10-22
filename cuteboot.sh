#!/system/bin/sh
export QT_QPA_PLATFORM=eglfs
export QT_QPA_GENERIC_PLUGINS=EvdevTouch
export QT_QPA_FONTDIR=/system/fonts
export LD_LIBRARY_PATH=/usr/lib:/system/lib:/vendor/lib
export QT_QPA_EGLFS_INTEGRATION=eglfs_surfaceflinger
export QT_QPA_EGLFS_HIDECURSOR=1 
exec /usr/bin/cutesystemserver
