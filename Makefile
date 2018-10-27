DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
USERID     := $(shell id -u)

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
	@ln -sfnv $(DOTPATH)/.config/nvim/init.vim $(HOME)/.vimrc
	@ln -sfnv $(DOTPATH)/.config/nvim $(HOME)/.vim
	@ln -sfnv ~/Dropbox/.fish_history ~/.local/share/fish/fish_history

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

install: deploy ## Run make deploy
	@exec $$SHELL

private: ## Clone private repository and create symlink
	@git clone https://github.com/yukimemi/private $(DOTPATH)/../private
	@ln -sfnv $(DOTPATH)/../private/.config/pet $(HOME)/.config/pet

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


install-peco: ## Install peco
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/install-peco.sh
install-gomi: ## Install gomi
	@curl -L git.io/gomi | bash
install-rustup: ## Install rustup
	@curl https://sh.rustup.rs -sSf | sh
install-rustfmt: ## Install rustfmt
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/install-rustfmt.sh

docker-neovim: ## Build neovim docker image
	@docker build --tag yukimemi/neovim --build-arg USERID=$(USERID) --build-arg USERNAME=${USER} --build-arg HOMEPATH=${HOME} -f ./docker/neovim/Dockerfile .

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
