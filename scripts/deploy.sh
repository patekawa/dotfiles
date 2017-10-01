#!/bin/bash
SCRIPT_DIR=$(dirname $0)
DOT_DIR=$(cd ${SCRIPT_DIR}/../; pwd)

deploy_for_env () {

    cd ${DOT_DIR}/$1

    for f in .??*
    do
        # Ignore some files
        [[ ${f} = ".git" ]] && continue
        ln -snfv ${DOT_DIR}/$1/${f} ${HOME}/${f}
    done

    echo "$(tput setaf 2)Deploy dotfiles for $1 complete!$(tput sgr0)"

}

deploy_for_env common
