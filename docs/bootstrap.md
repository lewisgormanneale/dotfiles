# Bootstrap flow (macOS)

1. `scripts/bootstrap`
   - Installs Homebrew if missing (macOS).
   - Runs `brew bundle` against `Brewfile` (includes fonts).
2. `scripts/link`
   - Symlinks `config/*` into `~/.config`.
   - Symlinks `config/zsh/.zshrc` → `~/.zshrc` and `config/git/.gitconfig` → `~/.gitconfig`.
   - Existing real files are backed up with a timestamp suffix.
3. `scripts/postinstall`
   - Runs `macos/defaults.sh` (optional tweaks).
   - Sets login shell to the brewed `zsh`.

Helpers:
- `make bootstrap` runs all steps.
- `make update` updates brew packages and syncs Neovim plugins.
- `make lint` runs shellcheck and stylua if installed.
