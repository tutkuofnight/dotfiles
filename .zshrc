# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias linutil='curl -fsSL https://christitus.com/linux | sh'
alias gs='git status'

alias conf='nvim ~/.config'
alias confr='nvim ~/.config/rofi/config.rasi'

alias confn='nvim ~/.config/nvim/init.lua'
alias confz='nvim ~/.zshrc'

alias confi='nvim ~/.config/i3/config'
alias confp='nvim ~/.config/poylbar/config.ini'

alias confh='nvim ~/.config/hypr/hyprland.conf'
alias confw='nvim ~/.config/waybar/config'

alias cc='claude'
alias cx='codex'

alias ccr='claude --resume'
alias cxr='codex resume'

yqs() { yay -Qs $@ }
qs() { pacman -Qs $@ }
unalias gc 2>/dev/null
gc() { git clone $@ }
v() { nvim $@ }

# Kitty shell integration
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# bun completions
[ -s "/home/tutku/.bun/_bun" ] && source "/home/tutku/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/home/tutku/.local/bin:$PATH"

# Android SDK (Expo dev build / emülatör)
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin

# pnpm
export PNPM_HOME="/home/tutku/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
