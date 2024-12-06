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
fish_add_path --path --append $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

set -x PYENV_ROOT $HOME/.pyenv
fish_add_path --path --append $PYENV_ROOT/bin
pyenv init - | source

zoxide init fish | source
starship init fish | source

export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

set -g fish_greeting

# Add abbreviations here instead of conf.d because we need to set $PATH first
source ~/.config/fish/abbrfile.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end
