#######################################
RED='\033[1;31m'
uncolor='\033[0m'

function echored {
    echo -e "${RED}$1${uncolor}"
}

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee -i deploy.log)

# Without this, only stdout would be captured - i.e. your
# log file would not contain any error messages.
# SEE (and upvote) the answer by Adam Spiers, which keeps STDERR
# as a separate stream - I did not want to steal from him by simply
# adding his answer to mine.
exec 2>&1

#######################################

#--------------------#
echored "apply configurations"
#--------------------#
bash ./.macos


#--------------------#
echored "installng home-brew"
#--------------------#
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


#--------------------#
echored "installng homebrew-cask"
#--------------------#
brew tap caskroom/cask


#-------------------#
echored "installing pip"
#-------------------#
sudo easy_install pip
sudo pip install --upgrade pip
pip --version
sudo pip install -r _pip/requirements.txt

#-------------------#
echored "installing oh-my-zsh"
#-------------------#
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


#-------------------#
#echored "configuring virtual env"
#-------------------#
#export WORKON_HOME=~/conf/pyenv/
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
#source /usr/local/bin/virtualenvwrapper.sh
#deactivate
#rmvirtualenv gen
#mkvirtualenv gen --system-site-packages
#workon gen
#pip install -r ./pip_req

#--------------------#
echored "installing cask packages"
#--------------------#
pushd _homebrew
brew bundle install -v
popd

#-------------------#
echored 'configure stow'
#-------------------#
stow --target=/Users/egreen stow

#-------------------#
echored "configuring oh-my-zsh"
#-------------------#
stow oh-my-zsh

#-------------------#
echored "configuring zsh"
#-------------------#
stow zsh

#-------------------#
echored 'configure ssh'
#-------------------#
stow ssh

#-------------------#
echored "cofiguring vim"
#-------------------#
stow vim

#-------------------#
echored "cofiguring git"
#-------------------#
stow git

#-------------------#
echored "cofiguring sublime text"
#-------------------#
stow git sublime_text_3/@osx

#-------------------#
echored "cofiguring lightcyber"
#-------------------#
stow git lightcyber


