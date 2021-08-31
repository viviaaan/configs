let &packpath = &runtimepath
let mapleader =" "
set guicursor=n-v-c:block,i-ci-ve:hor100,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

" Plugins

call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

call plug#end()

" nvim tree-sitter (syntax highlighting)

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp", "c", "python", "haskell", "html", "javascript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" basic configuration
    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox

    filetype plugin indent on
    set backspace=indent,eol,start
    set autoread
    set noshowmode noshowcmd
    set number relativenumber splitbelow splitright
    set smartcase nohlsearch incsearch
    set expandtab tabstop=4 softtabstop=4 shiftwidth=4 smartindent smarttab autoindent
    set termguicolors path+=**
    set scrolloff=1
    set sidescrolloff=5
    set wildmenu laststatus=2
    set ttimeout
    set ttimeoutlen=100
    set statusline =%F\ %m%r%=%y\ %{&ff}\ %l/%L\ %p%%\ %c

" netrw - built-in file browser
    let g:netrw_banner=0
    let g:netrw_liststyle=3
    let g:netrw_sizestyle="H"

" file opener with fuzzy searching
    map <C-f> :call fzf#run(fzf#wrap({'source': '$HOME/bin/fuzz'}))<CR>

" open terminal with current working directory as the same as the terminal running nvim
    map <C-n> :!setsid -f st > /dev/null 2>&1<CR><CR>

" make it easier to switch between split windows
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" make vertical resizing of split windows easier
    " map <C-s> <C-w>>
    " map <C-a> <C-w><

" easily switch between buffers
    map <leader>l :bn<CR>
    map <leader>h :bp<CR>

map <leader>w :w<CR>

" update xrdb after changing it
    autocmd BufWritePost Xresources !xrdb %

" toggle search highlighting
      let s:highlight_stat = 0
      function! ToggleHighlight()
          if s:highlight_stat == 0
            let s:highlight_stat = 1
            set hlsearch
          else
            let s:highlight_stat = 0
            set nohlsearch
          endif
       endfunction
map <leader>/ :call ToggleHighlight()<CR>

" set filetype using shortcuts
    map <leader>fs :set filetype=sh<CR>
    map <leader>ff :set filetype=cfg<CR>
    map <leader>fc :set filetype=c<CR>

" replace text thoroughout the entire buffer
    map <leader>r ggVG:s//g<Left><Left>

" go to an unique custom marker, delete it and go into insert mode
    map <leader><space> /<++><CR>cf>

nmap Q ZQ

" run shellcheck on current file
    autocmd FileType sh :map <leader>s :w! \| !shellcheck -x %<CR>

" disable auto-commenting on consequent new lines
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" remove all trailing whitespace and newlines when saving a file
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/\n\+\%$//e

" set filetype for some files
    autocmd BufNewFile,BufRead *.ms,*.mom set ft=groff
    autocmd BufNewFile,BufRead *.tex set ft=tex
    autocmd BufNewFile,BufRead .bookmarks set ft=conf
    autocmd BufNewFile,BufRead ~/bin/* set ft=sh

" autocompile dwm, dmenu and st builds
    autocmd BufReadPost config.h :map <leader>c :w! \| !"$HOME/bin/autocompile" %:p<CR>

" autocompile dwmblocks build
    autocmd BufReadPost blocks.h :map <leader>c :w! \| !cd "$HOME/dat/dwmblocks" ; sudo make install && killall -q dwmblocks ; setsid -f dwmblocks<CR>

" restart dunst after config edit
    autocmd BufWritePost dunstrc :silent !killall dunst ; setsid -f dunst

" go to the end of a journal entry file when opened
    autocmd BufRead ~/dat/journals/*.txt :normal G
    autocmd BufRead,BufNewFile ~/dat/journals/* :set textwidth=132

" the following are programming autocmds
" <leader>c is for compile, <leader>x is for execute, <leader>d is for executing in another window(d for debugging)

" compile
autocmd FileType c,cpp,haskell,python,asm :map <leader>c :w! \| !"$HOME/bin/compile" %:p<CR>

" execute compiled programs
autocmd FileType c,cpp,haskell,asm :map <leader>x :!st -t swallow /bin/sh -c "sleep 0.1 ; %:p:r ; echo '\nexit code : $?' ; sleep 1000000"<CR><CR>
autocmd FileType python :map <leader>x :w! \| !st -t swallow /bin/sh -c "sleep 0.1 ; python %:p ; echo '\nexit code : $?' ; sleep 1000000"<CR><CR>

" open the corresponding pdf file of a groff/latex source file
  autocmd FileType groff,tex :map <leader>o :!setsid -f zathura -c "$XDG_CONFIG_HOME/zathura_white" %:p:r.pdf<CR><CR>

" insert a basic C body for a new file
autocmd BufNewFile *.c -1r $HOME/.config/nvim/skeletons/clang
autocmd BufNewFile *.c :normal Gddgg

" compile with modifiable options (the left's are to get the cursor into proper position to add options)
autocmd FileType c :map <leader>C :w! \| !cc -pipe -Og -Wall %:p -o %:p:r<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" autocmd FileType cpp :map <leader>C :w! \| !g++ -pipe -Og -Wall %:p -o %:p:r<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>


" automatically insert a basic body for new file
" autocmd BufNewFile *.tex -1r $HOME/.config/nvim/skeletons/latex


" Compile as PostScript and convert to PDF
" autocmd FileType groff :map <leader>p :w! \| !groff -ms -kept %:p -Tps > %:p:r.ps && ps2pdf %:p:r.ps
