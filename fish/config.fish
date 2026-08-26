#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly, cross-platform shell
# https://fishshell.com

zoxide init fish | source
starship init fish | source

set -g -x PIP_REQUIRE_VIRTUALENV true
set -U fish_greeting
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

function fish_user_key_bindings
  bind \cs 'ta'
end

if type -q mise
    set -gx ODIN_ROOT (mise where odin 2>/dev/null)
end
