#!/usr/bin/bash
set -euo pipefail
IFS=$'\n\t'

main() {
    printf "=== Setting up Crystal Compiler Build Environment ===\n"

    # Define sudo prefix if not running as root
    local sudo_cmd=""
    if [[ $EUID -ne 0 ]]; then
        sudo_cmd="sudo"
    fi

    # 1. Ensure prereqs for adding repository are installed
    $sudo_cmd apt-get update
    $sudo_cmd apt-get install -y gnupg ca-certificates apt-transport-https wget

    # 2. Add the official upstream Open Build Service (OBS) repository for Crystal
    if [[ -r /etc/os-release ]]; then
        # shellcheck disable=SC1091
        . /etc/os-release
    else
        printf "ERROR: Cannot read /etc/os-release to detect Ubuntu version.\n" >&2
        return 1
    fi

    local distro_repo="xUbuntu_${VERSION_ID}"
    printf "Detected distribution release: %s\n" "$distro_repo"

    # Fetch repository signing key
    wget -qO- "https://download.opensuse.org/repositories/devel:/languages:/crystal/${distro_repo}/Release.key" | gpg --dearmor | $sudo_cmd tee /etc/apt/trusted.gpg.d/devel_languages_crystal.gpg > /dev/null

    # Add repository source
    printf "deb http://download.opensuse.org/repositories/devel:/languages:/crystal/%s/ /\n" "$distro_repo" | $sudo_cmd tee /etc/apt/sources.list.d/crystal.list

    # 3. Install compiler build/spec dependencies and the official crystal package
    $sudo_cmd apt-get update
    $sudo_cmd apt-get install -y \
        build-essential \
        llvm-dev \
        libgc-dev \
        libpcre2-dev \
        libevent-dev \
        libssl-dev \
        libxml2-dev \
        libyaml-dev \
        libgmp-dev \
        libreadline-dev \
        git \
        asciidoctor \
        crystal

    printf "=== Crystal Build Environment Setup Complete ===\n"
}

main "$@"
