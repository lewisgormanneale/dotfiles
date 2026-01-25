# Path & env ---------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less -FR"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Homebrew paths (macOS default)
if [[ -d /opt/homebrew/bin ]]; then
  [[ "$PATH" =~ ^/opt/homebrew/bin ]] || export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH:-}"
fi

# Zsh options --------------------------------------------------------------
setopt autocd extendedglob nomatch interactive_comments
setopt histignorealldups sharehistory incappendhistory
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=200000
SAVEHIST=200000

# Completion ---------------------------------------------------------------
autoload -Uz compinit
if [[ ! -d "${XDG_CACHE_HOME}/zsh" ]]; then mkdir -p "${XDG_CACHE_HOME}/zsh"; fi
if [[ ! -f "${XDG_CACHE_HOME}/zsh/.zcompdump" ]]; then compinit; else compinit -C; fi

# Prompt / theme -----------------------------------------------------------
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Plugins via Antidote -----------------------------------------------------
ANTIDOTE_DIR="${XDG_DATA_HOME}/antidote"
if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  ANTIDOTE_BUNDLE_FILE="${XDG_CONFIG_HOME}/zsh/antidote.txt"
  if [[ -f "$ANTIDOTE_BUNDLE_FILE" ]]; then
    antidote load "$ANTIDOTE_BUNDLE_FILE"
  fi
else
  echo "Antidote not installed; skipping plugin load."
fi

# Keybindings --------------------------------------------------------------
# fzf keybindings (brew)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi
bindkey -v                     # vi mode
bindkey '^R' fzf-history-widget

# Tooling -----------------------------------------------------------------
eval "$(direnv hook zsh 2>/dev/null || true)"
eval "$(zoxide init zsh --cmd cd 2>/dev/null || true)"
eval "$(atuin init zsh --disable-up-arrow 2>/dev/null || true)"

# Aliases ------------------------------------------------------------------
alias ll='eza -lha --git --icons=auto'
alias l='eza -lha'
alias cat='bat'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gl='git pull'
alias gp='git push'
alias gco='git checkout'
alias lg='lazygit'
alias k='kubectl'
alias tf='terraform'

# fzf config ---------------------------------------------------------------
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Load custom functions & aliases -----------------------------------------
for file in "${XDG_CONFIG_HOME}/zsh/aliases.d/"*.zsh(N); do source "$file"; done
for file in "${XDG_CONFIG_HOME}/zsh/functions.d/"*.zsh(N); do source "$file"; done
