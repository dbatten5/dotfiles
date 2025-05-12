setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE

setopt NO_BEEP
setopt CORRECT

# autoload functions
fpath=(~/.zsh/functions $fpath)
autoload -U $fpath[1]/*(.:t)

source ~/.zsh/keybind.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/export.zsh
source ~/.zsh/private.zsh

# INITIALISING PACKAGES

eval $(/opt/homebrew/bin/brew shellenv)

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)
export FZF_COMPLETION_TRIGGER='..'

# Created by `pipx` on 2023-12-24 10:00:49
export PATH="$PATH:/Users/dom.batten/.local/bin"
eval "$(/opt/homebrew/bin/brew shellenv)"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export WORKON_HOME=$HOME/.virtualenvs
pyenv global 3.12.7
pyenv virtualenvwrapper_lazy

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/Applications/Postgres.app/Contents/Versions/15/bin:$PATH"

export PATH="$PATH:$HOME/kafka/kafka_2.13-3.9.0/bin"

# Invoke tab-completion script to be sourced with the Z shell.
# Known to work on zsh 5.0.x, probably works on later 4.x releases as well (as
# it uses the older compctl completion system).

_complete_invoke() {
    # `words` contains the entire command string up til now (including
    # program name).
    #
    # We hand it to Invoke so it can figure out the current context: spit back
    # core options, task names, the current task's options, or some combo.
    #
    # Before doing so, we attempt to tease out any collection flag+arg so we
    # can ensure it is applied correctly.
    collection_arg=''
    if [[ "${words}" =~ "(-c|--collection) [^ ]+" ]]; then
        collection_arg=$MATCH
    fi
    # `reply` is the array of valid completions handed back to `compctl`.
    # Use ${=...} to force whitespace splitting in expansion of
    # $collection_arg
    reply=( $(invoke ${=collection_arg} --complete -- ${words}) )
}


# Tell shell builtin to use the above for completing our given binary name(s).
# * -K: use given function name to generate completions.
# * +: specifies 'alternative' completion, where options after the '+' are only
#   used if the completion from the options before the '+' result in no matches.
# * -f: when function generates no results, use filenames.
# * positional args: program names to complete for.
compctl -K _complete_invoke + -f invoke inv

# vim: set ft=sh :

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
