@echo off

doskey alias=if "$1"=="" (doskey /macros) else (doskey $*)
doskey unalias=doskey $*=
REM doskey cat=type $*
doskey cat=bat $*
doskey cp=copy $*
doskey h=doskey /history
doskey history=doskey /history
doskey ll=dir /ad $*
doskey la=dir $*
doskey l=dir $*
doskey t=exit
doskey ls=dir /w $*
doskey lv=more /E $*
doskey mv=move $*
doskey pwd=echo %CD%
doskey v=vim $*
doskey e=gvim --remote-tab-silent $*
doskey b=cd ..
doskey o=start $*
doskey vup=gvim -c "PlugUpdate | q"
doskey dup=gvim -c "silent! call dein#update() | q"
doskey mup=gvim -c "PackUpdate | q"

rem Git
doskey g=git $*
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
doskey gco=git checkout $*

if "%CMD_INIT_SCRIPT_LOADED%" neq "" goto :eof
set CMD_INIT_SCRIPT_LOADED=1

set GIT_EDITOR=nvim

set GSR_SHOW_AHEAD=1
set GSR_SHOW_BEHIND=1

rem cls
