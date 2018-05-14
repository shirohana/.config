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
3. [Mappings](#mappings)
    1. [Generic](#generic)
    2. [Moving](#moving)
    3. [Editing](#editing)
    4. [Command](#command)
    5. [Buffer](#buffer)
    6. [Window](#window)
    7. [Tabpage](#tabpage)
4. [Uninstall](#uninstall)

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

Mappings
--------

Alias                            | To
-----                            | --
<kbd>_&lt;Leader&gt;_</kbd>      | <kbd>Space</kbd>
<kbd>_&lt;LocalLeader&gt;_</kbd> | <kbd>;</kbd>
⌥                                | <kbd>Opt</kbd> (But we'll still use <kbd>Opt</kbd> because <kbd>⌥</kbd> is unreadable)
⇧                                | <kbd>Shift</kbd> (But we'll still use <kbd>Shift</kbd> because <kbd>⇧</kbd> is unreadable)
⌃                                | <kbd>Ctrl</kbd>

### Generic
| N   | I   | V   | Keystroke                    | Action
| :-: | :-: | :-: | ---------                    | ------
| v   | v   | v   | <kbd>⌃l</kbd>                | &lt;Esc&gt;
| v   |     |     | <kbd>Esc</kbd><kbd>Esc</kbd> | Cancal highlighe search

### Moving
| N   | Keystroke                | Action
| :-: | ---------                | ------
| v   | <kbd>z</kbd><kbd>h</kbd> | Move screen left
| v   | <kbd>z</kbd><kbd>l</kbd> | Move screen right
| v   | <kbd>\\</kbd>            | Jump to older cursor position
| v   | <kbd>&#124;</kbd>        | Jump to newer cursor position

### Editing
| N   | I   | Keystroke                | Action
| :-: | :-: | ---------                | ------
|     | v   | <kbd>O</kbd><kbd>O</kbd> | Insert one line above current editing line
|     | v   | <kbd>⌃a</kbd>            | Move cursor to start of line
|     | v   | <kbd>⌃e</kbd>            | Move cursor to end of line
| v   |     | <kbd>y</kbd><kbd>p</kbd> | Yank current paragraph and paste below

### Command
| C   | Keystroke     | Action
| :-: | ---------     | ------
| v   | <kbd>⌃a</kbd> | Move cursor to start of command
| v   | <kbd>⌃e</kbd> | Move cursor to end of command

### Buffer
| N   | Keystroke                               | Action
| :-: | ---------                               | ------
| v   | <kbd>Opt-t</kbd>                        | Create new buffer
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>w</kbd> | Save current buffer
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>q</kbd> | Wipe current buffer
| v   | <kbd>Opt-[</kbd>                        | Switch to previous buffer
| v   | <kbd>Opt-]</kbd>                        | Switch to next buffer

### Window
| N   | Keystroke                               | Action
| :-: | ---------                               | ------
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>h</kbd> | Create vertical split :arrow_left:
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>l</kbd> | Create vertical split :arrow_right:
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>j</kbd> | Create horizontal split :arrow_down:
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>k</kbd> | Create horizontal split :arrow_up:
| v   | <kbd>_&lt;Leader&gt;_</kbd><kbd>c</kbd> | Close current window
| v   | <kbd>Opt-h</kbd>                        | Move cursor :arrow_left:
| v   | <kbd>Opt-l</kbd>                        | Move cursor :arrow_right:
| v   | <kbd>Opt-j</kbd>                        | Move cursor :arrow_down:
| v   | <kbd>Opt-k</kbd>                        | Move cursor :arrow_up:
| v   | <kbd>&lt;Tab&gt;</kbd>                  | Move cursor to next window
| v   | <kbd>&lt;Shift-Tab&gt;</kbd>            | Move cursor to previous window
| v   | <kbd>&lt;Up&gt;</kbd>                   | Shrink window :arrow_up_down:
| v   | <kbd>&lt;Down&gt;</kbd>                 | Expand window :arrow_up_down:
| v   | <kbd>&lt;Left&gt;</kbd>                 | Shrink window :left_right_arrow:
| v   | <kbd>&lt;Right&gt;</kbd>                | Exapnd window :left_right_arrow:

### Tabpage
| N   | Keystroke              | Action
| :-: | ---------              | ------
| v   | <kbd>Opt-Shift-t</kbd> | Create new tab
| v   | <kbd>Opt-Shift-q</kbd> | Close current tab
| v   | <kbd>Opt-Shift-[</kbd> | Switch to previous tab
| v   | <kbd>Opt-Shift-]</kbd> | Switch to next tab

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
