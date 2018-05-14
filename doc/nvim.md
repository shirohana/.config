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
4. [Plugin Mappings](#plugin-mappings)
    1. [Airline](#airline)
    2. [AutoPairs](#autopairs)
    3. [Commentary](#commentary)
    4. [EasyAlign](#easyalign)
    5. [EasyMotion - Line Navigating](#easymotion---line-navigating)
    6. [EasyMotion - Word Navigating](#easymotion---word-navigating)
    7. [EasyMotion - Repeating](#easymotion---repeating)
    8. [EasyMotion - Searching](#easymotion---searching)
    9. [FZF](#fzf)
    10. [GitGutter](#gitgutter)
    11. [Incsearch](#incsearch)
    12. [MultipleCursors](#multiplecursors)
    13. [NERDTree](#nerdtree)
    14. [Peekaboo](#peekaboo)
    15. [Surround](#surround)
    16. [UndoTree](#undotree)
    17. [FileType: Markdown](#filetype-markdown)
5. [Uninstall](#uninstall)

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

Plugin Mappings
---------------

#### Airline
| N   | Keystroke        | Action
| :-: | ---------        | ------
| v   | <kbd>Opt-1</kbd> | Switch to 1st buffer
|     | ...              |
| v   | <kbd>Opt-9</kbd> | Switch to 9th buffer

#### AutoPairs
| I   | Keystroke     | Action
| :-: | ---------     | ------
| v   | <kbd>⌃b</kbd> | Back insert close pair in [fly-mode](https://github.com/jiangmiao/auto-pairs#fly-mode)

#### Commentary
| n   | v   | o   | Keystroke                            | Action
| :-: | :-: | :-: | ---------                            | ------
| v   | v   | v   | <kbd>g</kbd><kbd>c</kbd>             | Toggle comment of lines with {motion}
| v   |     |     | <kbd>g</kbd><kbd>c</kbd><kbd>c</kbd> | Toggle comment of current line
| v   |     |     | <kbd>c</kbd><kbd>g</kbd><kbd>c</kbd> | Change adjacent commented lines

#### EasyAlign
| n   | v   | Keystroke                | Action
| :-: | :-: | ---------                | ------
| v   |     | <kbd>g</kbd><kbd>a</kbd> | Start interactive EasyAlign with {motion}
|     | v   | <kbd>g</kbd><kbd>a</kbd> | Start **live** interactive EasyAlign in selection

#### EasyMotion - Line Navigating
Keystroke                                    | Action
---------                                    | ------
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>j</kbd> | &lt;Plug&gt;(easymotion-sol-j)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>J</kbd> | &lt;Plug&gt;(easymotion-j)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>k</kbd> | &lt;Plug&gt;(easymotion-sol-k)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>K</kbd> | &lt;Plug&gt;(easymotion-k)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>h</kbd> | &lt;Plug&gt;(easymotion-linebackward)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>l</kbd> | &lt;Plug&gt;(easymotion-lineforward)

#### EasyMotion - Word Navigating
Keystroke                                     | Action
---------                                     | ------
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>w</kbd>  | &lt;Plug&gt;(easymotion-w)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>W</kbd>  | &lt;Plug&gt;(easymotion-W)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>b</kbd>  | &lt;Plug&gt;(easymotion-b)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>B</kbd>  | &lt;Plug&gt;(easymotion-B)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>e</kbd>  | &lt;Plug&gt;(easymotion-e)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>E</kbd>  | &lt;Plug&gt;(easymotion-E)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>ge</kbd> | &lt;Plug&gt;(easymotion-ge)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>gE</kbd> | &lt;Plug&gt;(easymotion-gE)

#### EasyMotion - Repeating
Keystroke                                        | Action
---------                                        | ------
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>n</kbd>     | &lt;Plug&gt;(easymotion-n)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>N</kbd>     | &lt;Plug&gt;(easymotion-N)
<kbd>_&lt;LocalLeader&gt;_</kbd><kbd>Space</kbd> | &lt;Plug&gt;(easymotion-repeat)

#### EasyMotion - Searching
| N   | V   | O   | Keystroke                | Action
| :-: | :-: | :-: | ---------                | ------
| v   |     |     | <kbd>s</kbd><kbd>s</kbd> | &lt;Plug&gt;(easymotion-sn)
| v   |     |     | <kbd>s</kbd><kbd>f</kbd> | &lt;Plug&gt;(easymotion-fl)
| v   |     |     | <kbd>s</kbd><kbd>F</kbd> | &lt;Plug&gt;(easymotion-Fl)
| v   |     |     | <kbd>s</kbd><kbd>t</kbd> | &lt;Plug&gt;(easymotion-tl)
| v   |     |     | <kbd>s</kbd><kbd>T</kbd> | &lt;Plug&gt;(easymotion-Tl)
|     | v   |     | <kbd>f</kbd>             | &lt;Plug&gt;(easymotion-fl)
|     | v   |     | <kbd>F</kbd>             | &lt;Plug&gt;(easymotion-Fl)
|     | v   |     | <kbd>t</kbd>             | &lt;Plug&gt;(easymotion-tl)
|     | v   |     | <kbd>T</kbd>             | &lt;Plug&gt;(easymotion-Tl)
|     |     | v   | <kbd>f</kbd>             | &lt;Plug&gt;(easymotion-fl-fix)
|     |     | v   | <kbd>F</kbd>             | &lt;Plug&gt;(easymotion-Fl-fix)
|     |     | v   | <kbd>t</kbd>             | &lt;Plug&gt;(easymotion-tl-fix)
|     |     | v   | <kbd>T</kbd>             | &lt;Plug&gt;(easymotion-Tl-fix)

#### FZF
| N   | Keystroke        | Action
| :-: | ---------        | ------
| v   | <kbd>⌃o</kbd>    | Show opened files
| v   | <kbd>⌃p</kbd>    | Show files in `cwd`
| v   | <kbd>Opt-f</kbd> | Search text in `cwd`

#### GitGutter
| N   | Keystroke                                                    | Action
| :-: | ---------                                                    | ------
| v   | <kbd>s</kbd><kbd>j</kbd>                                     | Jump to next hunk
| v   | <kbd>s</kbd><kbd>j</kbd>                                     | Jump to previous hunk
| v   | <kbd>_&lt;LocalLeader&gt;_</kbd><kbd>s</kbd><kbd>s</kbd>     | Stage hunk under cursor
| v   | <kbd>_&lt;LocalLeader&gt;_</kbd><kbd>s</kbd><kbd>u</kbd>     | Unstage hunk under cursor
| v   | <kbd>_&lt;LocalLeader&gt;_</kbd><kbd>s</kbd><kbd>r</kbd>     | Undo hunk under cursor
| v   | <kbd>_&lt;LocalLeader&gt;_</kbd><kbd>s</kbd><kbd>Space</kbd> | Preview hunk under cursor

#### Incsearch
| N   | V   | Keystroke                            | Action
| :-: | :-: | ---------                            | ------
| v   | v   | <kbd>/</kbd>                         | Search pattern with highlight
| v   | v   | <kbd>?</kbd>                         | Search pattern back with highlight
| v   | v   | <kbd>g</kbd><kbd>/</kbd>             | Search pattern but stay cursor when cancel
| v   | v   | <kbd>z</kbd><kbd>/</kbd>             | Fuzzy search
| v   | v   | <kbd>z</kbd><kbd>?</kbd>             | Fuzzy search back
| v   | v   | <kbd>z</kbd><kbd>g</kbd><kbd>/</kbd> | Fuzzy search and stay when cancel

#### MultipleCursors
| N   | `MultiCursorMode` | Keystroke      | Action
| :-: | :---------------: | ---------      | ------
| v   |                   | <kbd>⌃n</kbd>  | Start multiple cursor mode on current word
|     | v                 | <kbd>⌃n</kbd>  | Join this word and jump to next
|     | v                 | <kbd>⌃x</kbd>  | Skip current word and jump to next
|     | v                 | <kbd>⌃b</kbd>  | Undo previous join or skip
|     | v                 | <kbd>Esc</kbd> | Leave `MultiCursorMode`

#### NERDTree
| N   | Keystroke        | Action
| :-: | ---------        | ------
| v   | <kbd>Opt-;</kbd> | Toggle NERDTree

#### Peekaboo
| N   | I   | V   | Keystroke     | Action
| :-: | :-: | :-: | ---------     | ------
| v   |     |     | <kbd>"</kbd>  | Peek register and do (e.g. `"4p`, `"ay`)
|     |     | v   | <kbd>"</kbd>  | Peek register and do
|     | v   |     | <kbd>⌃r</kbd> | Peek register and paste selected

#### Surround
| N   | V   | Keystroke                            | Action
| :-: | :-: | ---------                            | ------
| v   |     | <kbd>c</kbd><kbd>s</kbd>             | Change surround (e.g. `cs]{`, ``cs`<kbd>``)
| v   |     | <kbd>c</kbd><kbd>S</kbd>             | Change surround block (e.g. `cS}}`)
| v   |     | <kbd>d</kbd><kbd>s</kbd>             | Remove surround
| v   |     | <kbd>y</kbd><kbd>s</kbd>             | You surround with {motion} (e.g. `ysiw"`, `ysap<script>`)
| v   |     | <kbd>y</kbd><kbd>S</kbd>             | You surround block with {motion}
| v   |     | <kbd>y</kbd><kbd>s</kbd><kbd>s</kbd> | You surround current line
| v   |     | <kbd>y</kbd><kbd>S</kbd><kbd>S</kbd> | You surround block of current line
|     | v   | <kbd>S</kbd>                         | Surround selection
|     | v   | <kbd>g</kbd><kbd>S</kbd>             | Surround block of selection

#### UndoTree
| N   | Keystroke    | Action
| :-: | ---------    | ------
| v   | <kbd>U</kbd> | Toggle UndoTree

#### FileType: Markdown
| N   | Keystroke                | Action
| :-: | ---------                | ------
| v   | <kbd>[</kbd><kbd>[</kbd> | Jump to previous title
| v   | <kbd>]</kbd><kbd>]</kbd> | Jump to next title
| v   | <kbd>Enter</kbd>         | Open markdown preview on Safari ([`grip`](#markdown-preview-with-github) required)

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

[m-autopairs]: #autopairs
[m-commentary]: #commentary
[m-easyalign]: #easyalign
[m-easymotion]: #easymotion---line-navigating
[m-fzf]: #fzf
[m-gitgutter]: #gitgutter
[m-incsearch-easymotion]: #incsearch
[m-incsearch-fuzzy]: #incsearch
[m-incsearch]: #incsearch
[m-multicursors]: #multiplecursors
[m-nerdtree]: #nerdtree
[m-peekaboo]: #peekaboo
[m-surround]: #surround
[m-undotree]: #undotree
