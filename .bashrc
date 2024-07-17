function build() {
    local type=$1

    if type == 'd'; then
        cd ./build.w64/debug
        ninja install
    fi
}