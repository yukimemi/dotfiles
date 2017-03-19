@echo off

doskey alias=if "$1"=="" (doskey /macros) else (doskey $*)
doskey unalias=doskey $*=
doskey cat=type $*
doskey cp=copy $*
doskey h=doskey /history
doskey history=doskey /history
doskey ll=dir /ad
doskey ls=dir /w
doskey lv=more /E $*
doskey mv=move $*
doskey pwd=echo %CD%
doskey tree=tree /f $b more
doskey v=vim $*
doskey b=cd ..

rem Git
doskey s=git status
doskey a=git add $*
doskey d=git diff $*
doskey gci=git commit $*
doskey gb=git branch $*
doskey gba=git branch -a
doskey gbd=git branch -d $*
doskey gp=git pull --rebase $*
doskey gpu=git push $*
doskey gh=git show
doskey gr=git rebase $*
doskey gri=git rebase -i $*
doskey gl=git log
doskey glo=git log --oneline
doskey gk=git log --graph --pretty
doskey dup=vim -c "silent! call dein#update() | q"

if "%CMD_INIT_SCRIPT_LOADED%" neq "" goto :eof
set CMD_INIT_SCRIPT_LOADED=1

set GIT_EDITOR=vim

cls
