# Zsh:Prezto

# Vim:Dein
dein_url = "https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"
cache_dir = $(HOME)/.cache
dein_cache_dir = $(cache_dir)/nvim/dein

vim = $(if $(shell which nvim),nvim,$(shell which vim))

.PHONY: install update upgrade

default: install

install:
	make install-dein

install-dein:
	@echo \> Install dein from https://github.com/Shougo/dein.vim...
	@curl -o- -L $(dein_url) 2>/dev/null | bash -s $(dein_cache_dir) >/dev/null
	@echo \> Install plugins...
	@make dein-install
	@echo \> Dein and plugins install successfully!

dein-install:
	@$(vim) --cmd 'set t_ti= t_te=' -N \
		-c 'call dein#update() | echo dein#get_log() | if confirm("Install complete! Keep this window?", "&Yes\n&No", 2) == 2 | qall! | endif'

dein-update:
	@$(vim) --cmd 'set t_ti= t_te=' -N \
		-c 'call dein#clear_state() | call dein#update() | call dein#recache_runtimepath() | echo dein#get_log() | if confirm("Update complete! Keep this window?", "&Yes\n&No", 2) == 2 | qall! | endif'

dein-purge:
	@$(vim) --cmd 'set t_ti= t_te=' -N \
		-c "call map(dein#check_clean(), \"delete(v:val, 'rf')\") | call dein#recache_runtimepath() | qall!"
	@echo \> Done!

upgrade:
	@echo \> Pull last version from GitHub...
	@git pull --ff --ff-only
	@echo \> Updating...
	@make dein-update
	@echo \> Done! Everything is up to date
