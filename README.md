# vim_setup
1. :PlugInstall
2. :CocInstall coc-json
3. :CocConfig
  Put following in
  
  ```
  {
    "languageserver": {
      "golang": {
        "command": "gopls",
        "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
        "filetypes": ["go"]
      },
      "rust": {
        "command": "ra_lsp_server",
        "filetypes": ["rust"],
        "rootPatterns": ["Cargo.toml"]
      }
    }
  }
  ```
