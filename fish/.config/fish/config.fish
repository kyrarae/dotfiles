#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly, cross-platform shell
# https://fishshell.com

fish_add_path --path --prepend /usr/local/bin ~/.local/bin

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

set -x PYENV_ROOT $HOME/.pyenv
fish_add_path --path --append $PYENV_ROOT/bin
pyenv init - | source

zoxide init fish | source
starship init fish | source

set -U fish_greeting

set -Ux EDITOR hx
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
set -Ux VISUAL hx
