set autoindent
set number
set showmatch
set matchtime=1
set background=light
set backspace=indent,eol,start
syntax on
""set tags=~/*/tags
set tags=~/linux-kernel/timer-shield-kernel/tags
set scrolloff=999
set laststatus=2
set showcmd
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
" yanc until 1000 lines
" set viminfo='20,<1000,s10,h
set viminfo='50,<1000,s100
colorscheme darkblue
" set clipboard=unnamed,autoselect
set clipboard=unnamedplus

" yanc until the end of line
nnoremap Y y$

" increment and decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Auto detectionf of character code
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif

"
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set fileformats=unix,dos,mac

" if exists('&ambiwidth')
"   set ambiwidth=double
" endif

" show status line
set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ %m%h%r=%l/%L,%c%V\ %P
function! GetStatusEx()
	let str = &fileformat
	if has("multi_byte") && &fileencoding != ""
		let str = &fileencoding . ":" . str
	endif
	let str = "[" . str . "]"
	return str
endfunction


"
" vim-pathogen
"
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"
" neocomplcache.vim
"
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
	\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
let g:neocomplcache_snippets_dir = '~/.vim/snippets'

" カーソルを自動的に()の中へ
imap { {}<Left>
imap [ []<Left>
imap ( ()<Left>
imap < <><Left>
imap // /  /<left><left><left>
imap /* /*  */<left><left><left>
imap "" ""<Left>
imap '' ''<Left>
imap ** ``<Left>

"
" vim-smater
"
inoremap <expr> = smartchr#loop(' = ', '  == ', '=')
inoremap <expr> , smartchr#loop(', ', ',')

"
" unite.vim
"
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


" Set paste mode automatically,
" please refer http://qiita.com/ryoff/items/ad34584e41425362453e for details.
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set showtabline=2 " 常にタブラインを表示

" The prefix key.
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> <C-c> :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> <C-x> :tabclose<CR>
" tn 次のタブ
map <silent> <C-n> :tabnext<CR>
" tp 前のタブ
map <silent> <C-p> :tabprevious<CR>

" insert/reomve \ at the end of each lines.
vnoremap nn :normal $a \<CR>
vnoremap rnn :s/\s\+\\$//ge<CR>
" insert/reomve \\ at the end of each lines.
vnoremap nnn :normal $a \\<CR>
vnoremap rnnn :s/\s\+\\\\$//ge<CR>
" remove spaces from the first of line to next word.
nnoremap rsp 0<C-v>Whd<CR>

" Remove all space at the end of all lines automatically.
autocmd BufWritePre * :%s/\s\+$//ge

" color setting for vimdiff
hi DiffAdd    ctermfg = black ctermbg = 2
hi DiffChange ctermfg = black ctermbg = 3
hi DiffDelete ctermfg = black ctermbg = 6
hi DiffText   ctermfg = black ctermbg = 7
