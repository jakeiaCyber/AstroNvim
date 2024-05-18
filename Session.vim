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
badd +1 ~/.config/nvim/Session.vim
badd +27 ~/.config/nvim/lua/plugins/copilot.lua
badd +19 ~/.config/nvim/lua/plugins/vscode-icons.lua
argglobal
%argdel
edit ~/.config/nvim/lua/plugins/vscode-icons.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 54 + 54) / 109)
exe 'vert 2resize ' . ((&columns * 54 + 54) / 109)
argglobal
balt ~/.config/nvim/lua/plugins/copilot.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
8,34fold
4,35fold
2,36fold
1,37fold
let &fdl = &fdl
let s:l = 19 - ((18 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 022|
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/plugins/copilot.lua", ":p")) | buffer ~/.config/nvim/lua/plugins/copilot.lua | else | edit ~/.config/nvim/lua/plugins/copilot.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/plugins/copilot.lua
endif
balt ~/.config/nvim/lua/plugins/vscode-icons.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
5,7fold
3,8fold
16,19fold
14,20fold
11,21fold
23,27fold
2,28fold
let &fdl = &fdl
2
normal! zo
let s:l = 27 - ((26 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 27
let s:c = 57 - ((43 * winwidth(0) + 27) / 54)
if s:c > 0
  exe 'normal! ' . s:c . '|zs' . 57 . '|'
else
  normal! 057|
endif
wincmd w
exe 'vert 1resize ' . ((&columns * 54 + 54) / 109)
exe 'vert 2resize ' . ((&columns * 54 + 54) / 109)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
