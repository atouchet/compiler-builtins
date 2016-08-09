set -ex

. $(dirname $0)/env.sh

install_deps() {
    if [[ ${DOCKER} == "i" ]]; then
        apt-get update
        apt-get install -y --no-install-recommends \
                ca-certificates curl
    fi
}

install_qemu() {
    case $TARGET in
        powerpc64le-unknown-linux-gnu)
            apt-get install -y --no-install-recommends \
                    qemu-user
            ;;
    esac
}

install_binutils() {
    case $TRAVIS_OS_NAME in
        osx)
            brew install binutils
            ;;
        *)
            ;;
    esac
}

install_c_toolchain() {
    case $TARGET in
        aarch64-unknown-linux-gnu)
            sudo apt-get install -y --no-install-recommends \
                 gcc-aarch64-linux-gnu libc6-dev-arm64-cross
            ;;
        powerpc64le-unknown-linux-gnu)
            apt-get install -y --no-install-recommends \
                    gcc-powerpc64le-linux-gnu libc6-dev-ppc64el-cross
            ;;
        *)
            ;;
    esac
}

install_rust() {
    curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain=nightly

    rustc -V
    cargo -V
}

add_rustup_target() {
    if [[ $TARGET != $HOST ]]; then
        rustup target add $TARGET
    fi
}

configure_cargo() {
    if [[ $PREFIX ]]; then
        ${PREFIX}gcc -v

        mkdir -p .cargo
        cat >>.cargo/config <<EOF
[target.$TARGET]
linker = "${PREFIX}gcc"
EOF
    fi
}

main() {
    if [[ ${DOCKER:-n} != "y" ]]; then
        install_deps
        install_qemu
        install_binutils
        install_c_toolchain
        install_rust
        add_rustup_target
        configure_cargo
    fi
}

main