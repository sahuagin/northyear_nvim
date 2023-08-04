- [Features](#features)
- [Dependencies](#dependencies)
  - [python deps](#python-deps)
  - [r deps](#r-deps)
  - [lua deps](#lua-deps)
  - [vimscript deps](#vimscript-deps)
  - [markdown deps](#markdown-deps)
  - [sql deps](#sql-deps)
  - [bash deps](#bash-deps)
  - [latex deps](#latex-deps)
  - [cpp deps](#cpp-deps)
  - [general purpose deps](#general-purpose-deps)
- [Keymaps](#keymaps)
  - [Builtin keymaps](#builtin-keymaps)
    - [Builtin movement keymaps](#builtin-movement-keymaps)
    - [Builtin window keymaps](#builtin-window-keymaps)
    - [Builtin tab keymaps](#builtin-tab-keymaps)
    - [Builtin buffer keymaps](#builtin-buffer-keymaps)
    - [Builtin navigation keymaps](#builtin-navigation-keymaps)
  - [Builtin miscellenous keymaps](#builtin-miscellenous-keymaps)
  - [UI keymaps](#ui-keymaps)
    - [Pretty quickfix list keymaps](#pretty-quickfix-list-keymaps)
  - [Utils keymaps](#utils-keymaps)
    - [File explorer keymaps](#file-explorer-keymaps)
    - [Window layout keymaps](#window-layout-keymaps)
  - [Text Edit keymaps](#text-edit-keymaps)
    - [Align text keymaps](#align-text-keymaps)
    - [Comment keymaps](#comment-keymaps)
    - [Text objects for functions keymaps](#text-objects-for-functions-keymaps)
    - [Quick navigation keymaps](#quick-navigation-keymaps)
    - [Text objects enhancement keymaps](#text-objects-enhancement-keymaps)
    - [Block text movement](#block-text-movement)
    - [Surround pairs keymaps](#surround-pairs-keymaps)
    - [substitution keymaps](#substitution-keymaps)
    - [Other text objects keymaps](#other-text-objects-keymaps)
  - [Integration with other tools](#integration-with-other-tools)
    - [Terminal emulator keymaps](#terminal-emulator-keymaps)
    - [Git keymaps](#git-keymaps)
    - [Ripgrep keymaps](#ripgrep-keymaps)
    - [Copilot keymaps](#copilot-keymaps)
  - [REPL keymaps](#repl-keymaps)
  - [Treesitter keymaps](#treesitter-keymaps)
    - [Syntax based text objects keymaps](#syntax-based-text-objects-keymaps)
    - [Syntaxa based navigations keymaps](#syntaxa-based-navigations-keymaps)
    - [Miscellenous](#miscellenous)
  - [Searcher keymaps](#searcher-keymaps)
  - [Language Server Protocol keymaps](#language-server-protocol-keymaps)
  - [Autocompletion keymaps](#autocompletion-keymaps)
  - [Debugger Adapter Protocol keymaps](#debugger-adapter-protocol-keymaps)
  - [orgmode keymaps](#orgmode-keymaps)
  - [Filetype Specific Keymaps](#filetype-specific-keymaps)
    - [R keymaps](#r-keymaps)
      - [Builtin keymaps for R](#builtin-keymaps-for-r)
      - [REPL keymaps for R](#repl-keymaps-for-r)
    - [Python keymaps](#python-keymaps)
      - [Builtin keymaps for Python](#builtin-keymaps-for-python)
    - [REPL keymaps for Python](#repl-keymaps-for-python)
    - [Rmarkdown keymaps](#rmarkdown-keymaps)
      - [Builtin keymaps for Rmarkdown](#builtin-keymaps-for-rmarkdown)
      - [Text objects keymaps for Rmarkdown](#text-objects-keymaps-for-rmarkdown)
      - [REPL keymaps for Rmarkdown](#repl-keymaps-for-rmarkdown)
      - [Rmarkdown preview keymaps](#rmarkdown-preview-keymaps)
    - [Markdown keymaps](#markdown-keymaps)
    - [Latex keymaps](#latex-keymaps)
- [Other Notes](#other-notes)

# Features

- Built on modern devtools including LSP and treesitter. Treesitter delivers
  AST-level highlighting, text objects, and navigations, while LSP offers
  features like auto completion, go to definition and reference, and code
  diagnostics. By harnessing the power of both Ctags and LSP, this
  configuration brings a harmonic blend of old-school and modern development
  tools.

- Vim's exceptional text editing capabilities are further amplified by a host
  of powerful plugins focusing on text editing. (Remember it is pure text
  editing makes vim vim.)

- This configuration is specifically tailored toward data science toolsets,
  including python, R, SQL, Latex, rmarkdown, and quarto.

- Curated configuration working together with vscode thanks to
  [vscode-neovim](https://github.com/vscode-neovim/vscode-neovim). Access all
  the familiar neovim keybindings, including translations of equivalent
  commands in vscode, even when working with complex graphical content like
  Jupyter notebooks. And many neovim plugins, such as treesitter, can be
  embedded seamlessly in vscode, allowing for a smooth and uninterrupted
  workflow.

**NOTE**: If you plan to use this configuration with `vscode-neovim`, please
use the `windows/vscode` branch. If you wish to use neovim both in the terminal
and in vscode, we suggest creating two folders in `~/.config` or your specified
`$XDG_CONFIG` path. One is `~/.config/nvim`, which uses the default
configuration in the `master` branch, and the other is
`~/.config/vscode-neovim`, which uses the configuration in the `windows/vscode`
branch. This takes advantage of the `NVIM_APPNAME` feature in `nvim 0.9`. There
are two ways to ask `vscode-neovim` to use the configuration from the
`~/.config/vscode-neovim` folder as opposed to the default folder:

1. Create a bash script like the following:

```bash
#!bin/bash
NVIM_APPNAME=vscode-neovim nvim "$@"
```

Then, in vscode, set `vscode-neovim.neovimExecutablePaths.darwin` to
`your_path/to_the/bash_script`, changing darwin to match your system.

2. set `vscode-neovim.NVIM_APPNAME` to `vscode-neovim` in vscode settings.

## Be Wild

Randomly select a theme from a curated list each time you start up and
automatically switches between day and night themes at scheduled time.
Additionally, the displayed verses on the welcome screen is also randomized with
each launch. With neovim, you can have a fresh experience every time. Be casual
and wild!

# Showcase

![welcome-screen](assets/welcome-screen.png)

- The welcome screen displays two verses randomly selected from my curated
  collection. You can select new verses and color schemes at random or access
  frequently used commands from this screen.

![lsp](./assets/lsp-ctags.png)

- This screenshot showcases writing Lua code with smart autocompletion through
  both language server (LSP) and universal-ctags (ctags). This combination
  seamlessly blends old-school and modern tools. The bottom window shows the
  occurrence of referenced symbols that you specify (via `lsp find
  references`), while the right window shows the symbol outline of the current
  file (via `lsp document symbols`).

![literate-programming](./assets/literate-programming.png)

- This screenshot demonstrates the use of literate programming in neovim, which
  is highly beneficial for data science workflows. You can write code in both
  Python and R with intelligent autocompletion from both LSP and Ctags in quarto
  or markdown files. Moreover, you can send your code to both R and Python REPL
  simultaneously.

![dap](./assets/dap-python.png)

- This screenshot demonstrates how to debug Python program in neovim. Stepping through
  the code and watching variables and stack frames, just like in vscode.
>>>>>>> master

# Dependencies

You will need a C compiler in order to build the `treesitter`
grammar. This can be either `gcc`, `clang`, or `msvc`. To ensure that
Neovim can find the compiler, make sure it is included in your `PATH`.

# Keymaps

NOTE: this only includes keymaps defined by myself, and some of the
default plugins keymaps that I used frequently.

The `<Leader>` key is `<Space>`, the `<LocalLeader>` key is
`<Space><Space>` or `<Backslash>`.

In case you forget the keymaps you can always use `<Leader>fk`
(`:Telescope keymaps`) to find all keymaps.

## Builtin keymaps

### Builtin movement keymaps

| Mode | LHS     | RHS/Functionality                 |
| ---- | ------- | --------------------------------- |
| ic   | `<C-b>` | `<Left>`                          |
| ic   | `<C-p>` | `<Up>`                            |
| ic   | `<C-f>` | `<Right>`                         |
| ic   | `<C-n>` | `<Down>`                          |
| ic   | `<C-a>` | Go to Beginning of the line       |
| ic   | `<C-e>` | Go to end of the line             |
| ic   | `<C-h>` | `<Backspace>`                     |
| ic   | `<C-k>` | Del chars from cursor to line end |
| ic   | `<C-d>` | Delete a char forwardly           |
| c    | `<A-f>` | Move cursor to next word          |
| c    | `<A-b>` | Move cursor to previous word      |
| ivt  | `jk`    | Switch to normal mode             |

### Builtin window keymaps

| Mode | LHS           | RHS/Functionality                    |
| ---- | ------------- | ------------------------------------ |
| n    | `<A-f>`       | Move current win to prev tab         |
| n    | `<A-b>`       | Move current win to next tab         |
| n    | `<A-w>`       | Go to next win                       |
| n    | `<A-p>`       | Go to Prev win                       |
| n    | `<A-t>`       | Move this win to new tab             |
| n    | `<A-q>`       | Del this win                         |
| n    | `<A-v>`       | Vertically split current win         |
| n    | `<A-s>`       | Horizontally split current win       |
| n    | `<A-h>`       | Go to win to the left                |
| n    | `<A-j>`       | Go to win to the below               |
| n    | `<A-k>`       | Go to win to the above               |
| n    | `<A-l>`       | Go to win to the right               |
| n    | `<A-H>`       | Move current win to the left         |
| n    | `<A-J>`       | Move current win to the below        |
| n    | `<A-K>`       | Move current win to the above        |
| n    | `<A-L>`       | Move current win to the right        |
| n    | `<A-o>`       | Make current win the only win        |
| n    | `<A-=>`       | Balance the win height/width         |
| n    | `<A-\|>`      | Maximize current win's width         |
| n    | `<A-_>`       | Maximize current win's height        |
| n    | `<A-<>`       | Decrease current win's width         |
| n    | `<A->>`       | Increase current win's width         |
| n    | `<A-+>`       | Increase current win's height        |
| n    | `<A-->`       | Decrease current win's height        |
| n    | `<A-]>`       | Downward scroll the float win        |
| n    | `<A-[>`       | Upward scroll the float win          |
| n    | `<Leader>wf`  | Move current win to prev tab         |
| n    | `<Leader>wb`  | Move current win to next tab         |
| n    | `<Leader>ww`  | Go to next win                       |
| n    | `<Leader>wp`  | Go to Prev win                       |
| n    | `<Leader>wT`  | Move this win to new tab             |
| n    | `<Leader>wq`  | Del this win                         |
| n    | `<Leader>wv`  | Vertically split current win         |
| n    | `<Leader>ws`  | Horizontally split current win       |
| n    | `<Leader>wh`  | Go to win to the left                |
| n    | `<Leader>wj`  | Go to win to the below               |
| n    | `<Leader>wk`  | Go to win to the above               |
| n    | `<Leader>wl`  | Go to win to the right               |
| n    | `<Leader>wH`  | Move current win to the left         |
| n    | `<Leader>wJ`  | Move current win to the below        |
| n    | `<Leader>wK`  | Move current win to the above        |
| n    | `<Leader>wL`  | Move current win to the right        |
| n    | `<Leader>wo`  | Make current win the only win        |
| n    | `<Leader>w=`  | Balance the win height/width         |
| n    | `<Leader>w]`  | Downward scroll the float win        |
| n    | `<Leader>w[`  | Upward scroll the float win          |
| n    | `<Leader>w\|` | Maximize current win's width         |
| n    | `<Leader>w_`  | Maximize current win's height        |
| n    | `<Leader>w]`  | Jump to `tags` in a new window       |
| n    | `<Leader>wg]` | Select a tag to jump in a new window |

### Builtin tab keymaps

| Mode | LHS              | RHS/Functionality                |
| ---- | ---------------- | -------------------------------- |
| n    | `<Leader><Tab>[` | Go to next tab                   |
| n    | `<Leader><Tab>]` | Go to prev tab                   |
| n    | `<Leader><Tab>n` | Create a new tab                 |
| n    | `<Leader><Tab>c` | Close current tab                |
| n    | `<Leader><Tab>o` | Close other tabs except this one |
| n    | `<Leader><Tab>h` | Move tab to the left             |
| n    | `<Leader><Tab>l` | Move tab to the right            |
| n    | `<Leader><Tab>1` | Go to 1st tab                    |
| n    | `<Leader><Tab>2` | Go to 2nd tab                    |
| n    | `<Leader><Tab>3` | Go to 3rd tab                    |
| n    | `<Leader><Tab>4` | Go to 4th tab                    |
| n    | `<Leader><Tab>5` | Go to 5th tab                    |
| n    | `<Leader><Tab>6` | Go to 6th tab                    |
| n    | `<Leader><Tab>7` | Go to 7th tab                    |
| n    | `<Leader><Tab>8` | Go to 8th tab                    |
| n    | `<Leader><Tab>9` | Go to 9th tab                    |

### Builtin buffer keymaps

| Mode | LHS          | RHS/Functionality      |
| ---- | ------------ | ---------------------- |
| n    | `<Leader>bd` | Delete current buffer  |
| n    | `<Leader>bw` | Wipeout current buffer |
| n    | `<Leader>bp` | Prev buffer            |
| n    | `<Leader>bn` | Next buffer            |

### Builtin navigation keymaps

| Mode | LHS  | RHS/Functionality                                         |
| ---- | ---- | --------------------------------------------------------- |
| n    | `]b` | Next buffer                                               |
| n    | `[b` | Previous buffer                                           |
| n    | `]q` | Next quickfix list entry                                  |
| n    | `[q` | Prev quickfix list entry                                  |
| n    | `]Q` | Set current quickfix list as newer one in qflist history  |
| n    | `[Q` | Set current quickfix list as older one in qflist history  |
| n    | `]t` | Go to next tag location for currently searched symbol     |
| n    | `[t` | Go to previous tag location for currently searched symbol |

## Builtin miscellenous keymaps

| Mode | LHS           | RHS/Functionality                                      |
| ---- | ------------- | ------------------------------------------------------ |
| n    | `<Leader>olx` | Open URI under cursor using xdg-open                   |
| n    | `<Leader>olw` | Open URI under cursor using w3m                        |
| n    | `<C-g>`       | `<ESC>`                                                |
| n    | `<Leader>mt`  | search current word from tags file and send to loclist |
| n    | `<Leader>mdc` | Set working dir as current file's dir                  |
| n    | `<Leader>mdu` | Set working dir up one level from current working dir  |
| n    | `<Leader>mc`  | Pick a color scheme                                    |
| n    | `<Leader>th`  | Toggle highlight serach (see `:h hlsearch`)            |
| n    | `<Leader>tH`  | Toggle cmdheight between 0 or 1 (see `:h cmdheight`)   |
| n    | `<Leader>tw`  | Toggle wrap (see `:h wrap`)                            |
| n    | `<Leader>tc`  | set `conceallevel` between 0 and 2 (see `:h wrap`)     |

## UI keymaps

### Pretty quickfix list keymaps

The following keymaps rely on [Trouble.nvim](https://github.com/folke/trouble.nvim.git)

| Mode | LHS          | RHS/Functionality                                   |
| ---- | ------------ | --------------------------------------------------- |
| n    | `<Leader>xw` | Toggle display of workspace diagnostics via Trouble |
| n    | `<Leader>xd` | Toggle display of document diagnostics via Trouble  |
| n    | `<Leader>xl` | Toggle display of loclist via Trouble               |
| n    | `<Leader>xq` | Toggle display of quickfix list via Trouble         |
| n    | `<Leader>xr` | Toggle display of lsp references via Trouble        |

## Utils keymaps

### File explorer keymaps

The following keymaps rely on [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

| Mode | LHS          | RHS/Functionality                                          |
| ---- | ------------ | ---------------------------------------------------------- |
| n    | `<Leader>et` | Toggle file explorer via Nvimtree                          |
| n    | `<Leader>ef` | Toggle file explorer fosusing on current file via Nvimtree |
| n    | `<Leader>er` | Refresh Nvimtree file explorer                             |

### Window layout keymaps

The following keymaps rely on [winshift.nvim](https://github.com/sindrets/winshift.nvim)

| Mode | LHS          | RHS/Functionality        |
| ---- | ------------ | ------------------------ |
| n    | `<Leader>wm` | Rearrange windows layout |

## Text Edit keymaps

### Align text keymaps

The following keymaps rely on [vim-easy-align](https://github.com/junegunn/vim-easy-align)

| Mode | LHS | RHS/Functionality                                                 |
| ---- | --- | ----------------------------------------------------------------- |
| nv   | ga  | Align the motion / text object / selected text by input separator |

### Comment keymaps

The following keymaps rely on [mini.comment](https://github.com/echasnovski/mini.nvim)

| Mode | LHS | RHS/Functionality                                            |
| ---- | --- | ------------------------------------------------------------ |
| nv   | gc  | Comment / uncomment the motion / text object / selected text |
| n    | gcc | Comment /uncomment current line                              |
| o    | gc  | Text object: a commented text block                          |

### Text objects for functions keymaps

The following keymaps rely on [dsf.vim](https://github.com/AndrewRadev/dsf.vim)

| Mode | LHS  | RHS/Functionality                                     |
| ---- | ---- | ----------------------------------------------------- |
| n    | dsf  | Delete a function call, don't delete the arguments    |
| n    | dsnf | Delete next function call, don't delete the arguments |
| n    | csf  | Change a function call, keep arguments the same       |
| n    | csnf | Change next function call, keep arguments the same    |

### Quick navigation keymaps

The following keymaps rely on [vim-sneak](https://github.com/justinmk/vim-sneak)

| Mode | LHS | RHS/Functionality                       |
| ---- | --- | --------------------------------------- |
| nvo  | f   | Find the next input character           |
| nvo  | F   | Find the previous input character       |
| nvo  | t   | Guess from `t` vs `f` for vanilla vim   |
| nvo  | T   | Guess from `T` vs `F` for vanilla vim   |
| nv   | s   | Find the next 2 input chars             |
| o    | z   | Motion: Find the next 2 input chars     |
| n    | S   | Find the previous 2 input chars         |
| ov   | Z   | Motion: Find the previous 2 input chars |

### Text objects enhancement keymaps

The following keymaps rely on [mini.ai](https://github.com/echasnovski/mini.nvim)

| Mode | LHS  | RHS/Functionality                                             |
| ---- | ---- | ------------------------------------------------------------- |
| ov   | an   | Text object: find the next following "around" text object     |
| ov   | aN   | Text object: find the previous following "around" text object |
| ov   | in   | Text object: find the next following "inner" text object      |
| ov   | iN   | Text object: find the previous following "inner" text object  |
| nov  | `g(` | Motion: go to the start of the following "around" text object |
| nov  | `g)` | Motion: go to the end of the following "around" text object   |

### Block text movement

The following keymaps rely on [mini.move](https://github.com/echasnovski/mini.nvim)

| Mode | LHS     | RHS/Functionality            |
| ---- | ------- | ---------------------------- |
| v    | `<A-h>` | Move left the block of text  |
| v    | `<A-j>` | Move down the block of text  |
| v    | `<A-k>` | Move up the block of text    |
| v    | `<A-l>` | Move right the block of text |

### Surround pairs keymaps

The following keymaps rely on [mini.surround](https://github.com/echasnovski/mini.nvim)

| Mode | LHS | RHS/Functionality                                          |
| ---- | --- | ---------------------------------------------------------- |
| n    | yss | Add a surround pair for the whole line                     |
| n    | ys  | Add a surround pair for the following motion / text object |
| n    | yS  | Add a surround pair from cursor to line end                |
| v    | S   | Add a surround pair for selected text                      |
| n    | cs  | Change the surround pair                                   |
| n    | ds  | Delete the surround pair                                   |

### substitution keymaps

The following keymaps rely on [substitute.nvim](https://github.com/gbprod/substitute.nvim)

| Mode | LHS | RHS/Functionality                                                                                      |
| ---- | --- | ------------------------------------------------------------------------------------------------------ |
| nv   | gs  | Substitute the motion / text object / selected text by latest pasted text, don't cut the replaced text |
| n    | gss | Similar to `gs`, operate on the whole line                                                             |
| n    | gS  | Similar to `gs`, operate on text from cursor to line end                                               |

### Other text objects keymaps

The following keymaps rely on [vim-textobj-beween](https://github.com/thinca/vim-textobj-between)

| Mode | LHS | RHS/Functionality                                    |
| ---- | --- | ---------------------------------------------------- |
| ov   | ab  | Text object: around text between the input character |
| ov   | ib  | Text object: inner text between the input character  |

The following keymaps rely on [vim-textobj-chainmember](https://github.com/D4KU/vim-textobj-chainmember)

| Mode | LHS | RHS/Functionality                                     |
| ---- | --- | ----------------------------------------------------- |
| ov   | a.  | Text object: around a chain of chained method calls   |
| ov   | i.  | Text object: inner of a chain of chained method calls |

## Treesitter keymaps

### Syntax based text objects keymaps

| Mode | LHS          | RHS/Functionality                                |
| ---- | ------------ | ------------------------------------------------ |
| ov   | af           | Text object: around a function definition        |
| ov   | if           | Text object: inner of a function definition      |
| ov   | aC           | Text object: around a class definition           |
| ov   | iC           | Text object: inner of a class definition         |
| ov   | ak           | Text object: the same as `aC`                    |
| ov   | ik           | Text object: the same as `iC`                    |
| ov   | al           | Text object: around a loop                       |
| ov   | il           | Text object: inner of a loop                     |
| ov   | ac           | Text object: around if-else conditions           |
| ov   | ic           | Text object: inner of if-else conditions         |
| ov   | ae           | Text object: around a function call              |
| ov   | `a<Leader>a` | Text object: around a parameter(argument)        |
| ov   | `i<Leader>a` | Text object: inner of a parameter(argument)      |
| ov   | `<Leader>T`  | Text object: around the selected treesitter node |

### Syntaxa based navigations keymaps

| Mode | LHS          | RHS/Functionality                           |
| ---- | ------------ | ------------------------------------------- |
| n    | `]f`         | Go to the start of next function definition |
| n    | `]<Leader>c` | Go to the start of next class definition    |
| n    | `]k`         | The same as `]<Leader>c`                    |
| n    | `]l`         | Go to the start of next loop                |
| n    | `]c`         | Go to the start of next if-else conditions  |
| n    | `]e`         | Go to the start of next function call       |
| n    | `]a`         | Go to the start of next parameter(argument) |

| Mode | LHS          | RHS/Functionality                         |
| ---- | ------------ | ----------------------------------------- |
| n    | `]F`         | Go to the end of next function definition |
| n    | `]<Leader>C` | Go to the end of next class definition    |
| n    | `]K`         | The same as `]<Leader>C`                  |
| n    | `]L`         | Go to the end of next loop                |
| n    | `]C`         | Go to the end of next if-else conditions  |
| n    | `]E`         | Go to the end of next function call       |
| n    | `]A`         | Go to the end of next parameter(argument) |

| Mode | LHS          | RHS/Functionality                               |
| ---- | ------------ | ----------------------------------------------- |
| n    | `[f`         | Go to the start of previous function definition |
| n    | `[<Leader>c` | Go to the start of previous class definition    |
| n    | `[k`         | The same as `[<Leader>c`                        |
| n    | `[l`         | Go to the start of previous loop                |
| n    | `[c`         | Go to the start of previous if-else conditions  |
| n    | `[e`         | Go to the start of previous function call       |
| n    | `[a`         | Go to the start of previous parameter(argument) |

| Mode | LHS          | RHS/Functionality                             |
| ---- | ------------ | --------------------------------------------- |
| n    | `[F`         | Go to the end of previous function definition |
| n    | `[<Leader>C` | Go to the end of previous class definition    |
| n    | `[K`         | The same as `[<Leader>C`                      |
| n    | `[L`         | Go to the end of previous loop                |
| n    | `[C`         | Go to the end of previous if-else conditions  |
| n    | `[E`         | Go to the end of previous function call       |
| n    | `[A`         | Go to the end of previous parameter(argument) |

## Filetype Specific Keymaps

### R keymaps

#### Builtin keymaps for R

| Mode | LHS          | RHS/Functionality              |
| ---- | ------------ | ------------------------------ |
| ov   | `a<Leader>c` | Text objects: a code chunk     |
| ov   | `i<Leader>c` | Text objects: inner code chunk |

### Python keymaps

#### Builtin keymaps for Python

| Mode | LHS          | RHS/Functionality              |
| ---- | ------------ | ------------------------------ |
| ov   | `a<Leader>c` | Text objects: a code chunk     |
| ov   | `i<Leader>c` | Text objects: inner code chunk |

### Rmarkdown keymaps

#### Builtin keymaps for Rmarkdown

| Mode | LHS  | RHS/Functionality             |
| ---- | ---- | ----------------------------- |
| ov   | `ac` | Text object: a code chunk     |
| ov   | `ic` | Text object: inner code chunk |

#### Text objects keymaps for Rmarkdown

The following keymaps rely on [dsf.vim](https://github.com/AndrewRadev/dsf.vim)

| Mode | LHS  | RHS/Functionality                |
| ---- | ---- | -------------------------------- |
| ov   | `ae` | Text object: a function call     |
| ov   | `ie` | Text object: inner function call |

# Other Notes

1. `vim-sneak` defines relatively inconsistent behavior: in normal mode,
   use `s/S`, in operator pending mode, use `z/Z`, in visual mode,
   use `s/Z`. In normal mode, default mapping `s` is replaced.
   In op mode, use `z/Z` is to be compatible with `vim-surround` (mappings: `ys/ds/cs`),
   in visual mode, use `s/Z` is to be compatible with
   folding (mapping: `zf`) and `vim-surround` (mapping: `S`)

2. You need to define your leader key before defining any keymaps.
   Otherwise, keymap will not be correctly mapped with your leader key.

3. Note that `tree-sitter` will turn `syntax off`, and `pandoc-syntax` and `pandoc-rmarkdown`
   relies on the builtin `syntax`, so we need to load `config.pandoc` before we load `config.treesitter`

4. `vim-matchup` will (intentionally) hide the status-line if the matched pair are spanned
   over entire screen to show the other side of the pair.
