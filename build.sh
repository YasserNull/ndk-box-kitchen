#!/bin/bash
set -euo pipefail

die() {
    echo "ERROR: $*" >&2
    exit 1
}

# ndk-build lookup
if command -v ndk-build >/dev/null 2>&1; then
    NDK_BUILD="$(command -v ndk-build)"
elif [[ -n "${NDK_BUILD_PATH:-}" && -x "$NDK_BUILD_PATH" ]]; then
    NDK_BUILD="$NDK_BUILD_PATH"
else
    die "ndk-build not found. Set NDK_BUILD_PATH to the full path of ndk-build."
fi
FILES=(
    "busybox.config"
    "busybox/.config"
)

ARG="${1:-}"
SELINUX=""

if [[ -n "$ARG" && "$ARG" != "selinux" ]]; then
    die "invalid argument: '$ARG'. Use: ./build.sh [selinux]"
fi

if [[ "$ARG" == "selinux" ]]; then
    for f in "${FILES[@]}"; do
        [[ -f "$f" ]] || continue
        sed -i \
            -e 's/^#\?\(CONFIG_SELINUX=y\)/#\1/' \
            -e 's/^#\?\(CONFIG_FEATURE_TAR_SELINUX=y\)/#\1/' \
            -e 's/^#\?\(CONFIG_SELINUXENABLED=y\)/#\1/' \
            "$f"
    done
else
    for f in "${FILES[@]}"; do
        [[ -f "$f" ]] || continue
        SELINUX="DISABLE_SELINUX=1"
        sed -i \
            -e 's/^CONFIG_SELINUX=y/#CONFIG_SELINUX=y/' \
            -e 's/^CONFIG_FEATURE_TAR_SELINUX=y/#CONFIG_FEATURE_TAR_SELINUX=y/' \
            -e 's/^CONFIG_SELINUXENABLED=y/#CONFIG_SELINUXENABLED=y/' \
            "$f"
    done
fi

./run.sh generate
"$NDK_BUILD" clean
"$NDK_BUILD" "$SELINUX" -j"$(nproc)"
./run.sh archive

