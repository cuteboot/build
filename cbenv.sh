cb_select() {
	export CUTEBOOT_MAKEFILE=build/configs/$1/conf.mk
	. build/configs/$1/conf.sh
}
