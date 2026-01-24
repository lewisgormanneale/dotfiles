# My macOS dotfiles (Catppuccin)

Modern terminal + Neovim setup focused on speed and repeatability. macOS-only by design.

## Quickstart (macOS)

```sh
git clone https://github.com/yourname/dotfiles ~/.dotfiles
cd ~/.dotfiles
make bootstrap   # installs Homebrew + packages + links + mac defaults + fonts
```

Re-run `make link` after edits. Safe on existing machines: files are backed up with a timestamp before symlinking.

## Stack

- Terminal: Ghostty + tmux (Catppuccin Mocha)
- Shell: zsh (+ antidote plugins, starship, fzf, zoxide, atuin, direnv)
- Editor: Neovim (lazy.nvim, LSP via mason, treesitter, telescope, cmp, catppuccin)
- Package mgmt: Homebrew (+ Brewfile)

## Layout

- `scripts/` bootstrap, link, postinstall
- `config/` per-app configs in XDG layout (zsh, git, starship, tmux, ghostty, nvim)
- `macos/` optional defaults tweaks
- `bin/` small CLI helpers (add your own)
- `docs/` usage notes

## Next steps

- Drop in screenshots/GIFs once you’re happy with the look.
- Extend `hosts/<name>/` for per-machine overrides.
