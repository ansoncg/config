" Apenas para pequenas edicoes. Usar neovim para o resto.

" jk é bem facil que esc 
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>

" Usando o caps com map do simbolo de copyright

" Copy
nmap ©c "+yy
vmap ©c "+y

" Paste
nmap ©v "+p
imap ©v <Esc>"+pa
