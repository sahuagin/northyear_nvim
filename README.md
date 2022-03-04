1. Note that I use conda, so I set `let g:CONDA_PATHNAME = "your $CONDA_PREFIX"` at the start
of my `init.vim`. I found that source `conda init` in `.zshenv` would
make the start of nvim very slow, and I decide to not do it.

2. `devicons` should be the one that's last to be plugged in.

3. You should define `<leader>` key mappings before defining any keymaps that uses `<Leader>`.

4. nerd font need to be installed. One of the font is provided in the repository.

5. A somewhat annoying things compared to vscode is that I cannot manually set the workspace folder.
As a workaround, I set `<leader>cd` to change working directory to current file,
and `<leader>cu` to move upward one level