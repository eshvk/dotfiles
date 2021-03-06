#/bin/bash

# bash -c "$(curl -fsSL https://raw.github.com/nevillelyh/dotfiles/master/.dotfiles/scripts/bootstrap-dotfiles.sh)"

# fail early
set -e

# Packages:

# Mac:
# python - do not mess with OS X bundled python
# zinc - incremental compiler
# zsh (with --disable-etcdir)
# macvim (with --override-system-vim)
BREWS="ack colordiff ctags git htop httpie hub python tmux tree wget zinc z"

# Debian/Ubuntu:
# build-essential - for GCC, GNU Make, etc.
# ruby-dev - for Vim Command-T
DEB_PKGS="ack-grep build-essential colordiff curl exuberant-ctags git htop ruby-dev tmux tree vim-nox zsh"

# PIP:
PIP_PKGS="autoenv ipython virtualenv virtualenvwrapper flake8"

die() {
    echo "Error: $1"
    exit 1
}

ask() {
    while true; do
        read -p "$1 (y/n) " yn
        case $yn in
            y|Y|yes|YES) return 0;;
            n|N|no|NO)   return 1;;
            *)           echo "Please answer yes or no.";;
        esac
    done
}

_usr_local() {
    # homebrew works without owning /usr/local
    if [[ "$(uname)" != "Darwin" ]]; then
        # personal system, make /usr/local personal and bypass sudo
        sudo mv /usr/local /usr/local.orig
        sudo mkdir /usr/local
        sudo chown $(whoami):$(groups | awk '{print $1}') /usr/local
    fi
}

_aptitude() {
    sudo aptitude install ${DEB_PKGS}
}

_homebrew() {
    # homebrew packages
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install ${BREWS}

    # work around for OS X mis-configuration
    brew install --disable-etcdir zsh

    brew install macvim --with-override-system-vim
    brew linkapps macvim

    # htop requires root privileges
    sudo chown root:wheel /usr/local/Cellar/htop/*/bin/htop
    sudo chmod u+s /usr/local/Cellar/htop/*/bin/htop
}

_pip() {
    if ask "Install Python packages with pip?"; then
        owner=$(\ls -l /usr | grep -v '^l' | grep 'local$' | awk '{print $3}')
        if [[ "$(uname -s)" == "Darwin" ]] || [[ "${owner}" == "$(whoami)" ]]; then
            SUDO=""
        else
            SUDO="sudo"
        fi
        curl https://bootstrap.pypa.io/get-pip.py | ${SUDO} python
        ${SUDO} pip install ${PIP_PKGS}
        if [[ "$(uname -s)" != "Darwin" ]]; then
            ${SUDO} pip install httpie
        fi
    fi
}

_git() {
    if [[ -z ${http_proxy} ]]; then
        GIT_URL="git@github.com:nevillelyh/dotfiles.git"
    else
        GIT_URL="https://github.com/nevillelyh/dotfiles.git"
    fi

    cd ${HOME}
    git init
    git config branch.master.rebase true
    git remote add origin ${GIT_URL}
    git fetch
    git reset --hard origin/master
    git branch --set-upstream master origin/master
    git submodule update --init --recursive
}

_zsh() {
    # change default shell
    if [[ "$(uname -s)" == "Darwin" ]]; then
        cat << EOF | sudo tee -a /etc/shells
/usr/local/bin/zsh
EOF
        chsh -s /usr/local/bin/zsh
    else
        chsh -s /bin/zsh
    fi

    # Cannot add submodule within oh-my-zsh submodule
    mkdir -p ${HOME}/.dotfiles/zsh/omz/custom/plugins
    cd ${HOME}/.dotfiles/zsh/omz/custom/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
}

_vundle() {
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim -u ${HOME}/.vim/vimrc.d/vundle.vim +BundleInstall +qall
}

_commandt() {
    for cmd in ruby ruby1.8; do
        command -v ${cmd} > /dev/null && RUBY=${cmd} && break
    done
    cd ${HOME}/.vim/bundle/Command-T/ruby/command-t
    ${RUBY} extconf.rb
    make
    cd ${HOME}
}

cwd=$(pwd)

_usr_local
[[ -f /usr/bin/lsb_release ]] && _aptitude
[[ "$(uname -s)" == "Darwin" ]] && _homebrew
_pip
_git
_zsh
_vundle
_commandt

cd ${cwd}
