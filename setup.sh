#!bin/bash

echo "\n"
echo "################################################################"
echo "Beginning setup Fabio's development enviroment on Ubuntu 24.04.1"
echo "################################################################"

cd $HOME

sudo apt update

echo "\n"
echo "################################################################"
echo "Install cURL from apt"
echo "################################################################"
echo "\n"

sudo apt install curl -y

echo "\n"
echo "################################################################"
echo "Install Git from apt"
echo "################################################################"
echo "\n"

sudo apt install git -y

echo "\n"
echo "################################################################"
echo "Install build-essential from apt"
echo "################################################################"
echo "\n"

sudo apt install build-essential -y

echo "\n"
echo "################################################################"
echo "Clone config files repository"
echo "################################################################"
echo "\n"

if [ "$(ls -A $HOME/fabio-configs)" ]; then
  echo "Config files already exist"
else
  cd $HOME
  git clone https://github.com/fabioseixas/configs.git fabio-configs
fi

echo "\n"
echo "################################################################"
echo "Install Zsh from apt"
echo "################################################################"
echo "\n"

sudo apt install zsh -y
touch $HOME/.zshrc
echo "\n" >> $HOME/.bashrc
echo "zsh" >> $HOME/.bashrc

echo "\n"
echo "################################################################"
echo "Install nvm 0.40.1"
echo "################################################################"
echo "\n"

if [ "$(ls -A $HOME/.nvm)" ]; then
  echo "NVM is already installed"
else 
  PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
fi

# make "nvm" available for this process
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "\n"
echo "################################################################"
echo "Install Node v20"
echo "################################################################"
echo "\n"

nvm install 20

echo "\n"
echo "################################################################"
echo "Install NeoVim 0.10.3"
echo "################################################################"
echo "\n"

if [ "$(ls -A $HOME/nvim)" ]; then
  echo "NeoVim is already installed"
else 
  cd $HOME
  curl -LO https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
  sudo tar -xzf nvim-linux64.tar.gz
  mv nvim-linux64 nvim
  sudo rm -rf nvim-linux64.tar.gz
fi

export PATH=$PATH:$HOME/nvim/bin

echo "\n"
echo "################################################################"
echo "Install golang 1.24.4"
echo "################################################################"
echo "\n"

if [ "$(ls -A /usr/local/go)" ]; then
  echo "Golang is already installed"
else 
  curl https://dl.google.com/go/go1.23.4.linux-amd64.tar.gz --output go1.23.4.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
  go version
  sudo rm go1.23.4.linux-amd64.tar.gz 
fi

export PATH=$PATH:/usr/local/go/bin

echo "\n"
echo "################################################################"
echo "Fetch NeoVim config files"
echo "################################################################"
echo "\n"

if [ "$(ls -A $HOME/.config/nvim)" ]; then
  echo "NeoVim config files already exist"
else
  cd $HOME
  git clone https://github.com/fabioseixas/nvim-config.git .config/nvim
fi

echo "\n"
echo "################################################################"
echo "Install nvim plugins"
echo "################################################################"
echo "\n"

nvim --headless "+Lazy! install" +qa

echo "\n"
echo "################################################################"
echo "Install FiraCode"
echo "################################################################"
echo "\n"

if [ "$(ls -A .local/share/fonts)" ]; then
    echo "Fonts were found. Jumping to the next."
else
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts  
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Bold/FiraCodeNerdFont-Bold.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Bold/FiraCodeNerdFontMono-Bold.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Bold/FiraCodeNerdFontPropo-Bold.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Light/FiraCodeNerdFont-Light.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Light/FiraCodeNerdFontMono-Light.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Light/FiraCodeNerdFontPropo-Light.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Medium/FiraCodeNerdFont-Medium.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Medium/FiraCodeNerdFontMono-Medium.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Medium/FiraCodeNerdFontPropo-Medium.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFontPropo-Regular.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Retina/FiraCodeNerdFont-Retina.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Retina/FiraCodeNerdFontMono-Retina.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Retina/FiraCodeNerdFontPropo-Retina.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/SemiBold/FiraCodeNerdFont-SemiBold.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/SemiBold/FiraCodeNerdFontMono-SemiBold.ttf
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/SemiBold/FiraCodeNerdFontPropo-SemiBold.ttf
fi


echo "\n"
echo "################################################################"
echo "Gnome default terminal settings"
echo "################################################################"
echo "\n"

dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < ~/fabio-configs/terminal
gsettings set org.gnome.Terminal.ProfilesList default "e8356823-cb11-408f-a7f4-9b34f4228b82"
gsettings set org.gnome.Terminal.ProfilesList list "['e8356823-cb11-408f-a7f4-9b34f4228b82']"
echo "\n"
echo "Updated dconf terminal settings:"
echo "\n"
dconf dump /org/gnome/terminal/
echo "\n"
echo "Updated gettings terminal profiles:"
echo "\n"
gsettings get org.gnome.Terminal.ProfilesList default 
gsettings get org.gnome.Terminal.ProfilesList list 

echo "\n"
echo "################################################################"
echo "Install tmux from apt"
echo "################################################################"
echo "\n"

sudo apt install tmux -y

cp $HOME/fabio-configs/.tmux.conf $HOME/.tmux.conf

echo "\n"
echo "################################################################"
echo "Install tmux plugin manager"
echo "################################################################"
echo "\n"

cd $HOME
if [ "$(ls -A .tmux/plugins/tpm)" ]; then
    echo "Tmux plugin manager is already installed"
else
    git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm

    ~/.tmux/plugins/tpm/bin/install_plugins
fi

tmux source ~/.tmux.conf

echo "\n"
echo "################################################################"
echo "Copy .zshrc file"
echo "################################################################"
echo "\n"

cp $HOME/fabio-configs/.zshrc $HOME/.zshrc

echo "\n"
echo "################################################################"
echo "Install PowerLevel 10k"
echo "################################################################"
echo "\n"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo "\n"
echo "################################################################"
echo "FINISH"
echo "################################################################"
echo "\n"
