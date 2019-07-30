sudo npm install -g dockerfile-language-server-nodejs
sudo npm i -g bash-language-server
if [ ! -f ~/.vim/coc-settings.json ]; then
	ln -s coc-settings.json ~/.vim/coc-settings.json
fi
vim +PlugInstall +"CocInstall coc-json coc-rls" +qall!
