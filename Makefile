SHELL := /bin/bash

.PHONY: bootstrap link postinstall update lint brew

bootstrap: ## Install package manager + brew bundle + link configs + postinstall
	./scripts/bootstrap
	./scripts/link
	./scripts/postinstall

link: ## Symlink dotfiles via stow (idempotent)
	./scripts/link

postinstall: ## Mac defaults, fonts, shell
	./scripts/postinstall

update: ## Update brew bundle + nvim plugins
	brew update && brew upgrade
	brew bundle --file=Brewfile --cleanup
	nvim --headless \"+Lazy! sync\" +qa || true

lint: ## Run basic linters/formatters
	shellcheck scripts/* || true
	stylua config/nvim || true

brew: ## Install Homebrew (standalone)
	./scripts/bootstrap

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = \":.*?## \"}; {printf \"%-15s %s\\n\", $$1, $$2}'
