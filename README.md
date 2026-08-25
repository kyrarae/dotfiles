# Dotfiles

Personal dotfiles managed with [mise-en-place](https://mise.jdx.dev) for flexible, modular configuration management.

## Quick Start

```
# Install git
xcode-select --install

# Install mise
curl https://mise.run | sh

git clone https://github.com/kyrarae/dotfiles.git ~/.dotfiles

cd ~/.dotfiles
mise bootstrap dotfiles apply
```