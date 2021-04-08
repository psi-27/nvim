#!/usr/bin/env bash

(
    declare -A osInfo;
    osInfo[/etc/redhat-release]=yum
    osInfo[/etc/arch-release]=pacman
    osInfo[/etc/gentoo-release]=emerge
    osInfo[/etc/SuSE-release]=zypp
    osInfo[/etc/debian_version]=apt-get

    declare -A installCmd;
    installCmd[apt-get]="apt-get install -y"

    package_manager=''
    nvim_config_dir="${HOME}/.config/nvim"
    script_dir="$(dirname $(realpath "${BASH_SOURCE[0]}"))"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            echo Package manager: ${osInfo[$f]}
            package_manager="${osInfo[$f]}"
        fi
    done

    if [[ -z "$(which nvim)" ]];then sudo ${installCmd[${package_manager}]} neovim; fi


    if [[ ! -d "${nvim_config_dir}" ]];then
        mkdir -p "${nvim_config_dir}"
    fi

    mkdir "${nvim_config_dir}/vim-plug-root"

    cp -rv "${script_dir}/autoload" "${nvim_config_dir}/"
    cp -rv "${script_dir}/init.vim" "${nvim_config_dir}/"
)
