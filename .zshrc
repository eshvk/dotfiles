# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/zsh/omz
DEFAULT_USER=`whoami`

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# From here https://gist.github.com/kevin-smets/8568070
ZSH_THEME=powerlevel9k/powerlevel9k
# I installed `Sauce Code Pro Nerd Font Complete, this configuration ensures that I use this font`
POWERLEVEL9K_MODE='nerdfont-complete'
# Adding in conda environment
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir anaconda vcs)
# Adding in command execution time
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs history time)
# Always display command execution time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

# Adding snake icon for python
POWERLEVEL9K_PYTHON_ICON='\U1F40D'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.dotfiles/zsh/omz-custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Original list by Neville
# plugins=(colored-man git lein mvn pep8 pip sbt scala vundle zsh-syntax-highlighting z)
# Editing :Removing some plugins like lein mvn pep8 pip sbt scala vundle, want to remove 'z'
# but no idea what it does, 
# zsh syntax highlighting must be last plugin to be installed 
plugins=(colored-man git osx zsh-autosuggestions z zsh-syntax-highlighting)
[[ "$(uname)" == "Darwin" ]] && plugins=(brew osx ${plugins})

[[ -d ${HOME}/bin ]] && export PATH=${HOME}/bin:${PATH}

source $ZSH/oh-my-zsh.sh

# User configuration

# Miniconda Path
export PATH=$HOME/miniconda3/bin:$PATH

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Neville settings
source $HOME/.dotfiles/zsh/zshrc

