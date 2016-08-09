case $TRAVIS_OS_NAME in
    linux)
        export HOST=x86_64-unknown-linux-gnu
        export NM=nm
        export OBJDUMP=objdump
        ;;
    osx)
        export HOST=x86_64-apple-darwin
        export NM=gnm
        export OBJDUMP=gobjdump
        ;;
esac

case $TARGET in
    aarch64-unknown-linux-gnu)
        export PREFIX=aarch64-linux-gnu-
        export QEMU_LD_PREFIX=/usr/aarch64-linux-gnu
        ;;
    arm*-unknown-linux-gnueabi)
        export PREFIX=arm-linux-gnueabi-
        export QEMU_LD_PREFIX=/usr/arm-linux-gnueabi
        ;;
    arm*-unknown-linux-gnueabihf)
        export PREFIX=arm-linux-gnueabihf-
        export QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf
        ;;
    powerpc-unknown-linux-gnu)
        export PREFIX=powerpc-linux-gnu-
        export QEMU_LD_PREFIX=/usr/powerpc-linux-gnu
        ;;
    powerpc64le-unknown-linux-gnu)
        # NOTE $DOCKER values: 'y' (yes, call docker), 'i' (inside a docker container) or 'n' ("no)
        if [[ -z $DOCKER ]]; then
            export DOCKER=y
        fi
        export PREFIX=powerpc64le-linux-gnu-
        export QEMU=qemu-ppc64le
        export QEMU_LD_PREFIX=/usr/powerpc64le-linux-gnu
        ;;
esac