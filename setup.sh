sudo npm install -g dockerfile-language-server-nodejs
sudo npm i -g bash-language-server
ln coc-settings.json ~/.vim/coc-settings.json
vim +PlugInstall +"CocInstall coc-json coc-rls" +qall!