export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export GREP_OPTIONS='--color=auto'

LC_CTYPE=en_US.ISO8859-1; export LC_CTYPE
LC_CTYPE=zh_TW.UTF-8; export LC_ALL
LANG=zh_TW.UTF-8; export LANG


# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=1

source ~/.git-completion.bash
# as last entry source the gitprompt script
source ~/.bash-git-prompt/gitprompt.sh
