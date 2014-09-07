# Loïc's dotfiles

These dot files include configurations for the following software I use on a
regular basis:

- git
- mercurial
- vim
- tmux
- mutt
- matplotlib
- zsh
- latexmk
- gem

## Bootstraping

To get up and running quickly on a new machine, issue the following command

```bash
curl -fsSL https://raw.github.com/loicseguin/dotfiles/master/bootstrap.sh | bash
```

The boostrap script will take the following actions (without asking for your
permission — use with caution!):

- clone the github repository into `~/dotfiles`
- add appropriate symlinks and delete preexisting directories
- change the default shell to `zsh`
- install a bunch of software

## Installed software

- git
- homebrew
- mutt
- msmtp
- vim
- zsh
- tmux
