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
badd +5 ~/.config/nvim/lua/plugins/indent-tools.lua
badd +61 ~/.config/nvim/lua/plugins/nvchad-statusline.lua
argglobal
%argdel
edit ~/.config/nvim/lua/plugins/nvchad-statusline.lua
argglobal
balt ~/.config/nvim/lua/plugins/indent-tools.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
7,13fold
18,21fold
24,37fold
39,40fold
43,44fold
42,45fold
16,46fold
5,47fold
2,48fold
62,63fold
66,70fold
60,71fold
78,80fold
74,81fold
84,93fold
96,98fold
101,103fold
109,111fold
119,122fold
130,138fold
144,146fold
154,157fold
141,158fold
128,159fold
126,161fold
175,177fold
167,178fold
181,188fold
165,189fold
54,190fold
52,191fold
50,192fold
1,193fold
let &fdl = &fdl
1
normal! zo
2
normal! zo
5
normal! zo
16
normal! zo
let s:l = 61 - ((28 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 61
normal! 021|
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
