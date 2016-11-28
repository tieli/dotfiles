
#####################
# Alias list
#####################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ll="ls -lh"
alias la='ls -l'
alias lv='ls -F'
alias ls='ls -l --color=auto'

alias grep='grep -i --color'
alias fgrep='fgrep -n'
alias egrep='egrep -n'

alias vi='/usr/bin/vim'

alias pv='/home/tli/bin/perlmodver.sh'
alias pb='~/works/ansible/bin/ansible-playbook'

alias home="cd /home/tli"

alias ssh='ssh -o GSSAPIAuthentication=no'
alias ssh_ec2='ssh -i ~/.ssh/cjwawskey.pem'
alias clearscreen="screen -ls | grep tach | cut -f2 | xargs -I{} screen -S {} -X quit"
alias virt_env="source /home/tli/virt_env/env02/bin/activate"

alias xterm="xterm -fa 'Monospace' -fs 15"

alias r="rails"

alias mkdate="mkdir $(date '+%d_%b_%Y')"
