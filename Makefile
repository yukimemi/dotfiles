DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
USERID     := $(shell id -u)
GROUPID    := $(shell id -g)
USERNAME   := $(shell id -un)
GROUPNAME  := $(shell id -gn)

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@mkdir -p $(HOME)/.local/bin > /dev/null 2>&1
	@ln -sfnv $(DOTPATH)/etc/scripts $(HOME)/.local/bin/scripts
	@mkdir -p $(HOME)/.local/share/fish > /dev/null 2>&1
	@ln -sfnv ~/GoogleDrive/.local/share/fish/fish_history ~/.local/share/fish/fish_history
	@ln -sfnv ~/GoogleDrive/.z ~/.z

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

install: deploy ## Run make deploy
	@exec $$SHELL

private: ## Clone private repository and create symlink
	@git clone https://github.com/yukimemi/private $(DOTPATH)/../private
	@ln -sfnv $(DOTPATH)/../private/.config/pet $(HOME)/.config/pet
	@ln -sfnv $(DOTPATH)/../private/.slack-term $(HOME)/.slack-term

private-link: ## Create symlink private config
	@ln -sfnv $(DOTPATH)/../private/.config/pet $(HOME)/.config/pet
	@ln -sfnv $(DOTPATH)/../private/.slack-term $(HOME)/.slack-term

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	@-rm -vrf $(HOME)/.local/bin/scripts

ubuntu-fish: ## Install fish on ubuntu
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/ubuntu/install-fish.sh
ubuntu-neovim: ## Install neovim on ubuntu
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/ubuntu/install-neovim.sh
ubuntu-vim: ## Install vim on ubuntu
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/ubuntu/install-vim.sh
ubuntu-tmux: ## Install tmux on ubuntu
	sudo snap install --classic tmux

mac-homebrew: ## Install Homebrew
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/mac/install-homebrew.sh
mac-keyhac: ## Deploy keyhac settings
	@ln -sfnv $(DOTPATH)/mac/keyhac/config.py $(HOME)/Library/Application\ Support/Keyhac/config.py
	@ln -sfnv $(DOTPATH)/mac/keyhac/keyhac.ini $(HOME)/Library/Application\ Support/Keyhac/keyhac.ini

install-peco: ## Install peco
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/install-peco.sh
install-gomi: ## Install gomi
	@curl -L git.io/gomi | bash
install-rustup: ## Install rustup
	@curl https://sh.rustup.rs -sSf | sh
install-rustfmt: ## Install rustfmt
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/install-rustfmt.sh
install-spacevim: ## Install spacevim
	@curl -sLf https://spacevim.org/install.sh | bash

docker-neovim: ## Build neovim docker image
	docker build --tag yukimemi/neovim --build-arg USERID=$(USERID) --build-arg USERNAME=$(USERNAME) --build-arg GROUPID=$(GROUPID) --build-arg GROUPNAME=$(GROUPNAME) --build-arg HOMEPATH=${HOME} -f ./docker/neovim/Dockerfile .

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
