alias linutil='curl -fsSL https://christitus.com/linux | sh'
alias gs='git status'

alias conf='nvim ~/.config'

alias confn='nvim ~/.config/nvim/init.lua'
alias confz='nvim ~/.zshrc'

alias confi='nvim ~/.config/i3/config'
alias confp='nvim ~/.config/poylbar/config.ini'

alias confh='nvim ~/.config/hypr/hyprland.conf'
alias confw='nvim ~/.config/waybar/config'

yqs() { yay -Qs $@ }
qs() { pacman -Qs $@ }
unalias gc 2>/dev/null
gc() { git clone $@ }
v() { nvim $@ }

