#!/bin/bash

# Install dotfiles along with a bunch of really useful software.
# Run with
#   curl -LO https://raw.github.com/loicseguin/dotfiles/master/bootstrap.sh
#   bash bootstrap.sh

DOTDIR=$HOME/dotfiles

# Are dotfiles already in place? If so, we are done.
if [ -d $DOTDIR ]; then
    echo "dotfiles seem to be already installed"
    exit 1
fi

# Try to determine the package manager to use for installing software.
case $OSTYPE in
    darwin*)
        # Use homebrew on OS X
        hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"; }
        INSTALL="brew install"
        ;;
    linux*)
        # Try a couple of installers for the most well known distributions
        if hash apt-get 2>/dev/null; then
            INSTALL="sudo apt-get install"
        elif hash yum 2>/dev/null; then
            INSTALL="sudo yum install"
        elif hash pacman 2>/dev/null; then
            INSTALL="sudo pacman -S"
        elif hash zypper 2>/dev/null; then
            INSTALL="sudo zypper install"
        fi
        ;;
    *)
        echo "You're using some weird OS, I can't help you with it."
        exit 1
        ;;
esac

check_install() {
    # If a command is in the PATH, do nothing. Otherwise, attempt install.
    hash $1 2>/dev/null || { $INSTALL $1; }
}

install_vim() {
    case $OSTYPE in
        darwin*)
            # Get MacVim snapshot because installing from Homebrew requires
            # Xcode
            curl -OL https://github.com/b4winckler/macvim/releases/download/snapshot-73/MacVim-snapshot-73-Mavericks.tbz
            tar zxvf MacVim-snapshot-73-Mavericks.tbz
            mv MacVim-snapshot-73/MacVim.app /Applications/MacVim.app
            mv MacVim-snapshot-73/mvim $HOME/bin/mvim
            ln -s $HOME/bin/mvim $HOME/bin/vim
            ln -s $HOME/bin/mvim $HOME/bin/vimdiff
            ln -s $HOME/bin/mvim $HOME/bin/view
            rm -rf MacVim-snapshot-73*
            ;;
        linux*)
            # Install vim and gvim
            check_install vim
            check_install gvim
            ;;
        *)
            echo "You're using some weird OS, install vim yourself."
            ;;
    esac
}

# Version control
ln -Ffs $DOTDIR/hgrc $HOME/.hgrc
ln -Ffs $DOTDIR/hgignore $HOME/.hgignore
ln -Ffs $DOTDIR/gitconfig $HOME/.gitconfig
# Make sure git is installed
check_install git

# Clone the repository
git clone https://github.com/loicseguin/dotfiles.git $DOTDIR

# Vim
ln -Ffs $DOTDIR/vim $HOME/.vim
ln -Ffs $DOTDIR/vim/vimrc $HOME/.vimrc
mkdir -p $DOTDIR/vim/bundle
mkdir -p $DOTDIR/vim/tmp/backup
mkdir -p $DOTDIR/vim/tmp/undo
install_vim
# Get all plugins
git clone https://github.com/gmarik/Vundle.vim.git $DOTDIR/vim/bundle/Vundle.vim
vim +BundleInstall +q +q

# Matplotlib
mkdir -p $HOME/.matplotlib
ln -Ffs $DOTDIR/matplotlibrc $HOME/.matplotlibrc

# LaTeX
ln -Ffs $DOTDIR/latexmkrc $HOME/.latexmkrc

# Zsh
ln -Ffs $DOTDIR/zsh/zshrc $HOME/.zshrc
ln -Ffs $DOTDIR/zsh $HOME/.zsh
check_install zsh
chsh -s `command -v zsh`
touch $HOME/.hushlogin  # Silence! (no "Last login on ..." message)

# Miscellaneous
ln -Ffs $DOTDIR/gemrc $HOME/.gemrc
