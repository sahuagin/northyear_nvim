" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1


" above is the default setting when installing neovim. Will not change it
" following is my setting
set nu
set autoindent
set softtabstop=4 expandtab shiftwidth=4
set autoindent
set showcmd
set ignorecase smartcase

filetype plugin indent on

autocmd BufRead,BufNewFile *.jl      set filetype=julia

" set the derminal working at the current directory
autocmd BufEnter * silent! lcd %:p:h



" keybinding remap for global keys
let mapleader = ' '
imap jk <Esc>
" let g:mapleader = ' '

" function to enabling the same plugin (at different fork), primarily
" for vscode neovim extension.
" to use it, you need to copy two lines of installation commamnd
" in !exists('g:vscode') branch, as you need to call
" `:PlugInstall` in nvim terminal to install the fork for Vscode
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" condition brach for different setting in nvim terminal and vscode
if !exists('g:vscode')

    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set termguicolors

    call plug#begin()

        " Set the Theme for nvim
        " Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
        Plug 'altercation/vim-colors-solarized'

        " Set the theme for statusbar
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        " Set the advanced text editing and jumping plug
        Plug 'easymotion/vim-easymotion'
        Plug 'tpope/vim-surround'
        Plug 'preservim/nerdcommenter'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-repeat'
        " Plug 'vim-scripts/argtextobj.vim'
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'wellle/targets.vim'

        " Tree sitter for enhanced text obj and syntax capturality
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/nvim-treesitter-textobjects'
        Plug 'p00f/nvim-ts-rainbow'

        " Set markdown syntax highlighting
        Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['rmarkdown', 'markdown']}
        Plug 'vim-pandoc/vim-rmarkdown', {'for': 'rmarkdown'}

        " Set FZF for file search
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'

        " a simple format code plugin
        Plug 'pappasam/vim-filetype-formatter', {'for': ['r', 'rmarkdown', 'python', 'markdown']}
        Plug 'kdheepak/JuliaFormatter.vim', { 'for': 'julia'}

        " Very simple, naive completion
        Plug 'skywind3000/vim-auto-popmenu'
        Plug 'skywind3000/vim-dict'

        " Deal with input method, automatically changed to English
        " input method when switch to normal mode
        Plug 'ybian/smartim'
        
        " support browser
        " Plug 'glacambre/firenvim'

        

    call plug#end()

    "let g:tokyonight_style = "day"
    "colorscheme tokyonight

    syntax enable

    set background=light
    colorscheme solarized

    " Enable C-bpfn to move cursor when in editor mode
    inoremap <C-b> <Left>
    inoremap <C-f> <Right>
    inoremap <C-p> <Up>
    inoremap <C-n> <Down>

    " set fontsize for firenvim
    " set guifont=Fira_Code:h22
    
    " source for treesitter config, airline config, autoformatter config
    so /Users/northyear/.config/nvim/nvimtsconf.vim
    so /Users/northyear/.config/nvim/arlineconf.vim
    so /Users/northyear/.config/nvim/autoFormatConf.vim

    
else 
    " configuration only valid in vscode neovim mode 

    
    call plug#begin()

        Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }

        Plug 'tpope/vim-surround'
        Plug 'preservim/nerdcommenter'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-repeat'
        Plug 'vim-scripts/argtextobj.vim'
        Plug 'wellle/targets.vim'
        " Plug 'michaeljsmith/vim-indent-object'

        " Tree sitter for enhanced text obj and syntax capturality
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/nvim-treesitter-textobjects'

        " Deal with input method, automatically changed to English
        " input method when switch to normal mode
        Plug 'ybian/smartim'




    call plug#end()
    
    so /Users/northyear/.config/nvim/vstsconf.vim

endif


" change the indentation style for R
" ie the newline indentatino for () is identical to {}
let r_indent_align_args = 0
let r_indent_ess_comments = 0
let r_indent_ess_compatible = 0


" define some customized shortcut globally
nmap gs <Plug>(easymotion-s2)

" some customized configuration for plugins
let g:EasyMotion_smartcase = 1
let g:NERDCreateDefaultMappings = 1



