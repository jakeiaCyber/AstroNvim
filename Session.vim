let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +19 init.lua
badd +0 ~/.zshrc
badd +0 ~/workspace/codes/test.cpp
badd +0 .git/config
badd +0 .gitignore
badd +0 README.md
badd +0 lua/plugins/vscode.lua
badd +0 lua/plugins/whichkey.lua
badd +0 lua/plugins/user.lua
badd +0 lua/plugins/snippet.lua
badd +0 lua/plugins/nvchad-statusline.lua
badd +0 lua/plugins/actions-preview.lua
badd +0 lua/plugins/astroui.lua
badd +0 lua/plugins/copilot.lua
badd +0 lua/plugins/treesitter.lua
badd +0 lua/polish.lua
badd +0 lua/community.lua
badd +0 lua/plugins/indent-tools.lua
badd +0 lua/plugins/disable.lua
badd +0 lazy-lock.json
badd +0 lua/plugins/mini-file.lua
badd +0 lua/plugins/cmp.lua
badd +0 lua/plugins/transparent.lua
badd +0 lua/plugins/mason.lua
badd +0 lua/plugins/context.lua
badd +0 lua/plugins/none-ls.lua
badd +0 lua/plugins/notify.lua
badd +33 lua/plugins/astrocore.lua
badd +0 lua/lazy_setup.lua
argglobal
%argdel
edit lua/plugins/astrocore.lua
argglobal
balt init.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
14,20fold
31,34fold
28,35fold
27,36fold
24,37fold
23,38fold
22,39fold
43,44fold
42,46fold
50,59fold
61,64fold
49,65fold
77,80fold
76,82fold
71,89fold
91,93fold
69,94fold
12,95fold
9,96fold
let &fdl = &fdl
let s:l = 33 - ((23 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 33
normal! 08|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
