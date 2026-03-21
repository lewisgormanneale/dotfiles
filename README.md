# My macOS dotfiles (Catppuccin Mocha)

## Quickstart (macOS)

```sh
git clone https://github.com/lewisgormanneale/dotfiles ~/.dotfiles
cd ~/.dotfiles
make bootstrap   # installs Homebrew + packages + links + mac defaults + fonts
```

Re-run `make link` after edits. Safe on existing machines: files are backed up with a timestamp before symlinking.

## Stack

- Terminal: Kitty
- Shell: zsh (+ antidote plugins, starship, fzf, zoxide, atuin, direnv)
- Editor: Neovim (lazy.nvim, LSP via mason, treesitter, telescope, cmp, catppuccin)
- Package mgmt: Homebrew (+ Brewfile)

## Layout

- `scripts/` bootstrap, link, postinstall
- `config/` per-app configs in XDG layout (zsh, git, starship, tmux, ghostty, nvim)
- `macos/` macOS default system preferences
- `bin/` small CLI helpers
- `docs/` usage notes
