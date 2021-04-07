#!/usr/bin/env bash

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get

declare -A pmCmd;
pmCmd[apt-get]="apt-get install -y"

package_manager=''

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        echo Package manager: ${osInfo[$f]}
        package_manager="${osInfo[$f]}"
    fi
done

if [[ -z "$(which nvim)" ]];then sudo ${pmCmd[${package_manager}]} neovim; fi

echo $(dirname $(realpath "${BASH_SOURCE[0]}"))"/autoload"
echo ${HOME}"/.local/nvim/site"



if [[ ! -d ${HOME}"/.local/share/nvim/site" ]];then
    mkdir -p ${HOME}"/.local/share/nvim/site"
fi

cp -rv $(dirname $(realpath "${BASH_SOURCE[0]}"))"/autoload" ${HOME}"/.local/share/nvim/site/"


if [[ ! -d ${HOME}"/.config/nvim" ]];then
    mkdir -p ${HOME}"/.config/nvim"
fi

cp -rv $(dirname $(realpath "${BASH_SOURCE[0]}"))"/init.vim" ${HOME}"/.config/nvim"
