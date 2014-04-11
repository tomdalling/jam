nmap <leader>tr :w<cr>:!clear && (cd example && ruby game.rb)<cr>
nmap <leader>tb :w<cr>:!clear && gem build jam.gemspec && gem install --dev jam*.gem && rm jam*.gem<cr>
