vim.cmd [[
      " Add spaces after comment delimiters by default
      let g:NERDSpaceDelims            = 1
      " Disable commenting empty lines
      let g:NERDCommentEmptyLines      = 0
      " use compact syntax for prettified multi-line comments
      let g:NERDCompactSexyComs        = 1
      " trim trailing whitespace
      let g:NERDTrimTrailingWhitespace = 1
      " left align the comment
      let g:NERDDefaultAlign           = 'left'
      " wisely comment on a region
      let g:NERDToggleCheckAllLines = 1
      noremap <leader>cl <plug>NERDCommenterAlignLeft
      noremap <space>c<leader> <plug>NERDCommenterToggle
      nmap <BS> <plug>NERDCommenterToggle
      vmap <BS> <plug>NERDCommenterToggle
    ]]
