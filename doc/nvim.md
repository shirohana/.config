NeoVim
======

#### Menu
1. [Installation](#installation)
2. [Plugins](#plugins)
    1. [Plugin Manager](#plugin-manager)
    2. [Appearance](#appearance)
    3. [File Navigation](#file-navigation)
    4. [Moving & searching](#moving--searching)
    5. [Editing](#editing)
    6. [Utility](#utility)
    7. [Language](#language)
3. [Uninstall](#uninstall)

Installation
------------

_* as required_

#### *Install NeoVim
```sh
brew install neovim
```

#### *Setup environment
```sh
ln -s $(realpath ./config/nvim) $(realpath ~/.config/nvim)
make bootstrap
```

#### Markdown preview with GitHub
_GitHub access token required_
```sh
brew install grip
```
Create a new token with **NO** permission from [GitHub personal access tokens page](https://github.com/settings/tokens).
```sh
export GITHUB_AUTH=YOUR_TOKEN
```

#### Intergration with
- Node.js: `npm install -g neovim`
- Ruby: `gem install neovim`
- python2: `pip install neovim`
- python3: `pip3 install neovim`

Plugins
-------

### Plugin Manager
Name                    | Description
----                    | -----------
[Shougo/dein.vim][dein] | :zap: Dark powered Vim/Neovim plugin manager

### Appearance
Name                                             | Description
----                                             | -----------
[vim-airline/vim-airline][airline]               | :triangular_ruler: Lean & mean status/tabline
[vim-airline/vim-airline-themes][airline-themes] | Themes for `vim-airline`
[itchyny/vim-cursorword][cursorword]             | :pencil2: Underlines the word under the cursor
[lifepillar/vim-solarized8][solarized8]          | [Solarized][solarized] with true color support

### File Navigation
&nbsp;               | Name                                               | Description
------               | ----                                               | -----------
[:memo:][m-fzf]      | [junegunn/fzf.vim][fzf]                            | :mag: fzf & vim & ag
[:memo:][m-nerdtree] | [scrooloose/nerdtree][nerdtree]                    | :open_file_folder: Tree explorer
&nbsp;               | [Xuyuanp/nerdtree-git-plugin][nerdtree-git-plugin] | Showing git status in `NERDTree`

### Moving & Searching
&nbsp;                           | Name                                                        | Description
------                           | ----                                                        | -----------
[:memo:][m-easymotion]           | [easymotion/vim-easymotion][easymotion]                     | :fire: Vim motions on speed!
[:memo:][m-incsearch]            | [haya14busa/incsearch.vim][incsearch]                       | :flashlight: Improved incremental searching
[:memo:][m-incsearch-easymotion] | [haya14busa/incsearch-easymotion.vim][incsearch-easymotion] | Integration between `incsearch` and `easymotion`
[:memo:][m-incsearch-fuzzy]      | [haya14busa/incsearch-fuzzy.vim][incsearch-fuzzy]           | Intremental fuzzy search extensions for `incsearch`

### Editing
&nbsp;                   | Name                                         | Description
------                   | ----                                         | -----------
[:memo:][m-autopairs]    | [shirohana/auto-pairs][autopairs]            | :coffee: Insert/Delete quotes in pair
[:memo:][m-commentary]   | [tpope/vim-commentary][commentary]           | :hash: Toggle comments in line/block
[:memo:][m-easyalign]    | [junegunn/vim-easy-align][easyalign]         | :left_right_arrow: Alignning like a boss
[:memo:][m-gitgutter]    | [airblade/vim-gitgutter][gitgutter]          | :octocat: Show git diffs and preview changes
[:memo:][m-multicursors] | [terrtma/vim-multiple-cursors][multicursors] | :dart: Multiple selections
[:memo:][m-peekaboo]     | [junegunn/vim-peekaboo][peekaboo]            | :eyes: Peeking register
[:memo:][m-surround]     | [tpope/vim-surround][surround]               | :coffee: Quoting pairs simple
[:memo:][m-undotree]     | [mbbill/undotree][undotree]                  | :leftwards_arrow_with_hook: Undo history visualizer
&nbsp;                   | [ntpeters/vim-better-whitespace][whitespace] | :coffee: Highlight trailing whitespaces and remove them on save

### Utility
Name                       | Description
----                       | -----------
[tpope/vim-repeat][repeat] | Allow plugins repeat multi-actions  with <kbd>.</kbd>

### Language
Language | Repo
-------- | ----
Markdown | [plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown)
&nbsp;   | [JamshedVesuna/vim-markdown-preview](https://github.com/JamshedVesuna/vim-markdown-preview)
TOML     | [cespare/vim-toml](https://github.com/cespare/vim-toml)

Uninstall
---------

```sh
unlink ~/.config/nvim
rm -rf ~/.cache/nvim
```

<!-- References -->

[airline-themes]: https://github.com/vim-airline/vim-airline-themes
[airline]: https://github.com/vim-airline/vim-airline
[autopairs]: https://github.com/shirohana/auto-pairs
[commentary]: https://github.com/tpope/vim-commentary
[cursorword]: https://github.com/itchyny/vim-cursorword
[dein]: https://github.com/Shougo/dein.vim
[easyalign]: https://github.com/junegunn/vim-easy-align
[easymotion]: https://github.com/easymotion/vim-easymotion
[fzf]: https://github.com/junegunn/fzf.vim
[gitgutter]: https://github.com/airblade/vim-gitgutter
[incsearch-easymotion]: https://github.com/haya14busa/incsearch-easymotion.vim
[incsearch-fuzzy]: https://github.com/haya14busa/incsearch-fuzzy.vim
[incsearch]: https://github.com/haya14busa/incsearch.vim
[multicursors]: https://github.com/terryma/vim-multiple-cursors
[nerdtree-git-plugin]: https://github.com/Xuyuanp/nerdtree-git-plugin
[nerdtree]: https://github.com/scrooloose/nerdtree
[peekaboo]: https://github.com/junegunn/vim-peekaboo
[repeat]: https://github.com/tpope/vim-repeat
[solarized8]: https://github.com/lifepillar/vim-solarized8
[solarized]: https://github.com/altercation/vim-colors-solarized
[surround]: https://github.com/tpope/vim-surround
[undotree]: https://github.com/mbbill/undotree
[whitespace]: https://github.com/ntpeters/vim-better-whitespace

[m-autopairs]: #
[m-commentary]: #
[m-easyalign]: #
[m-easymotion]: #
[m-fzf]: #
[m-gitgutter]: #
[m-incsearch-easymotion]: #
[m-incsearch-fuzzy]: #
[m-incsearch]: #
[m-multicursors]: #
[m-nerdtree]: #
[m-peekaboo]: #
[m-surround]: #
[m-undotree]: #
