# Dotfiles

## Install

```
# Install git
xcode-select --install
git clone https://github.com/kyrarae/dotfiles.git ~/.dotfiles
cd ~/.dotfiles; source install.sh

```

Use `stow`to symlink, eg:

```
stow brew && stow fish
```

## Brew and brew bundle

After the .Brewfile is symlinked into ~/.Brewfile, just use:
`brew bundle --global`

To replace the Brewfile, run:
`brew bundle dump --global -f`
