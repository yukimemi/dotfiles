let g:autobackup_backup_dir = $BACKUP_PATH .. '/autobackup'
let g:autobackup_backup_limit = 500

silent! call mkdir(g:autobackup_backup_dir, 'p')

