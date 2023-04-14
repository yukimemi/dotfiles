call operator#sandwich#set('add', 'char', 'skip_space', 1)
au MyAutoCmd ModeChanged [vV\x16]*:* call operator#sandwich#set('add', 'char', 'skip_space', 1)
au MyAutoCmd ModeChanged *:[vV\x16]* call operator#sandwich#set('add', 'char', 'skip_space', 0)

