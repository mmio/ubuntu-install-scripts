#!/bin/bash

# use org-mode then tangle into a script
# Emacs configuration rewrite everything to use use-package
# Emacs tern - npm stuff ?
# change touchpad settings to tap-to-click
# Create a script to connect to STU VPN without actual password via GDG
# Add optional fingerprint reader configutation

# Directories
git_dir=~/Repos
bkp_dir=~/Repos/ubuntu-install-scripts

msg() {
    echo "------|" $1 "|------"
}

# Exit on error
set -e

upgrade_system() {
    msg "Upgrading System"

    sudo apt update
    sudo apt upgrade -y

    msg "FINISHED - Upgrading System"
}

add_repositories() {
    msg "Adding repositories"

    #sudo add-apt-repository ppa:saiarcot895/chromium-dev
    #sudo apt-get update
    #sudo apt install chromium-browser

    # Install driver manually
    # https://www.linuxuprising.com/2018/08/how-to-enable-hardware-accelerated.html
    # sudo apt-mark hold vdpau-va-driver

    msg "Finished Adding repositories"
}

add_deb_packages() {
    # The following sofware should be installed from deb packages
    # vscode or codium
    # megasync
    # ungoogled-chromium
    # figma linux
    # lbry
    # slack

    # wget -c https://downloads.slack-edge.com/linux_releases/slack-desktop-4.8.0-amd64.deb -O /tmp/slack-desktop-4.8.0-amd64.deb
    # sudo dpkg -i /tmp/slack-desktop-4.8.0-amd64.deb
    # sudo apt install -f
    
    # curl -s https://api.github.com/repos/Figma-linux/figma-linux/releases/latest \
    # 	| grep "browser_download_url.*deb" \
    # 	| cut -d : -f 2,3 \
    # 	| tr -d \" \
    # 	| wget -O /tmp/figma-linux.deb -i -
    # sudo dpkg -i /tmp/figma-linux.deb
    # sudo apt install -f

    # curl -s https://api.github.com/repos/lbryio/lbry-desktop/releases/latest \
    # 	| grep "browser_download_url.*deb" \
    # 	| cut -d : -f 2,3 \
    # 	| tr -d \" \
    # 	| wget -O /tmp/lbry.deb -i -
    # sudo dpkg -i /tmp/lbry.deb
    # sudo apt install -f

    # Not sure if this will work in the future
    # wget -c https://az764295.vo.msecnd.net/stable/db40434f562994116e5b21c24015a2e40b2504e6/code_1.48.0-1597304990_amd64.deb -O /tmp/code_amd64.deb
    # sudo dpkg -i /tmp/code_amd64.deb
    # sudo apt install -f
    
    # megasync, this will be the most difficult

    # Upgrade in case of outdated .deb files
    # sudo apt update && sudo apt upgrade -y
}

install_base_software() {
    msg "Installing Software"

    sudo apt install --no-install-recommends numlockx emacs-lucid git rxvt-unicode unifont fonts-font-awesome \
	 ranger i3 i3lock i3blocks make gcc sudo libreoffice tlp htop feh compton \
	 pulsemixer arandr zathura zathura-pdf-poppler deluged deluge-console \
	 xbacklight xss-lock network-manager\
	 xinit mpv qutebrowser ffmpeg chromium curl -y

    # Not sure if this is needed after removing the gtk3, gtk2 and qt versions
    echo 'export SAL_USE_VCLPLUGIN=gen' >> ~/.bashrc
    
    msg "FINISHED - Installing Software"
}

install_software() {
    msg "Installing Software"

    sudo apt install make gcc emacs rofi git rxvt-unicode compton\
	 nitrogen ranger i3blocks i3lock libreoffice tlp powertop htop sxiv \
	 thunderbird pavucontrol preload inkscape gimp cheese python-pip \
	 arandr zathura zathura-pdf-poppler zathura-ps zathura-djvu zathura-cb \
	 openvpn lxappearance curl g++ pandoc flameshot w3m w3m-img xbacklight \
	 mpv chromium-browser snapd pcmanfm cups jq megatools -y

    # sudo apt install texlive-latex-base texlive-fonts-recommended \
    # 	 texlive-fonts-extra -y
    # sudo apt install texlive-latex-extra

    # sudo snap install spotify
    # sudo snap install pycharm-community --classic
    # sudo snap install intellij-idea-community --classic
    # sudo snap install webstorm --classic
    # sudo snap install datagrip --classic

    msg "FINISHED - Installing Software"
}

clone_repos() {
    msg "Cloning repos"

    if [ ! -d "$git_dir/urxvt-resize-font" ]; then
	git clone https://github.com/simmel/urxvt-resize-font.git $git_dir/urxvt-resize-font
    fi

    if [ ! -d "$git_dir/i3" ]; then
	git clone https://github.com/Airblader/i3.git $git_dir/i3
    fi

    if [ ! -d "~/.nvm" ]; then
	    git clone https://github.com/nvm-sh/nvm.git ~/.nvm
    fi

    # if [ ! -d "$git_dir/polybar" ]; then
    # 	git clone --recursive https://github.com/jaagr/polybar.git $git_dir/polybar
    # fi

    # if [ ! -d "$git_dir/light" ]; then
    # 	git clone https://github.com/haikarainen/light.git $git_dir/light
    # fi

    # if [ ! -d "$git_dir/bash_it" ]; then
    # 	git clone --depth=1 https://github.com/Bash-it/bash-it.git $git_dir/bash_it
    # fi

    if [ ! -d "$git_dir/bashmount" ]; then
	git clone https://github.com/jamielinux/bashmount.git $git_dir/bashmount
    fi

    msg "FINISHED - Cloning repos"
}

i3_deps() {
    msg "Installing i3gaps deps"

    sudo apt install –no-install-recommends libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	 libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	 libstartup-notification0-dev libxcb-randr0-dev \
	 libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	 libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	 autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev -y

    msg "FINISHED - Installing i3gaps deps"
}

i3_build_install() {
    msg "Building and Installing i3gaps"

    cd $git_dir/i3
    git checkout gaps
    autoreconf --force --install

    rm -rf build/
    mkdir -p build/
    cd build/

    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
    make
    sudo make install

    msg "FINISHED - Building and Installing i3gaps"
}

i3_configure() {
    msg "Configuring i3gaps"
    
    mkdir -p ~/.config/i3
    
    cp $bkp_dir/i3wm/i3/config ~/.config/i3/
    cp $bkp_dir/i3wm/i3/config.org ~/.config/i3/
    cp $bkp_dir/i3wm/i3/volumeUp.sh ~/.config/i3/
    cp $bkp_dir/i3wm/i3/volumeDown.sh ~/.config/i3/
    cp $bkp_dir/i3wm/i3/volumeMute.sh ~/.config/i3/

    msg "FINISHED - Configuring i3gaps"
}

polybar_deps() {
    msg "Installing Polybar deps"

    sudo apt install –no-install-recommends build-essential git cmake cmake-data pkg-config libcairo2-dev libxcb1-dev \
	 libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev \
	 libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev \
	 libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
	 libiw-dev libnl-3-dev -y

    msg "FINISHED - Installing Polybar deps"
}

polybar_install() {
    msg "Installing Polybar"

    cd $git_dir/polybar
    rm -rf build/
    mkdir build/
    cd build/

    cmake ..
    sudo make install

    msg "FINISHED - Installing Polybar"
}

polybar_configure() {
    msg "Configuring Polybar"

    mkdir -p ~/.config/polybar
    
    cp $bkp_dir/polybar/config ~/.config/polybar/
    cp $bkp_dir/polybar/launch.sh ~/.config/polybar/

    msg "FINISHED - Configuring Polybar"
}

bash-it_configure() {
    msg "Configuring BashIt"

    cd $git_dir/bash_it
    ./install.sh --silent
    sed -i 's/BASH_IT_THEME=.*/BASH_IT_THEME="zork"/' ~/.bashrc
    
    msg "FINISHED - Configuring BashIt"
}

keras_tensorflow_install() {
    msg "Installing Tensorflow"
    
    sudo apt-get install –no-install-recommends python3-pip python3-dev python-virtualenv -y

    mkdir ~/keras_w_tensorflow
    cd ~/keras_w_tensorflow
    virtualenv --system-site-packages -p python3 kwtf
    source kwtf/bin/activate
    pip install -U pip
    pip install $bkp_dir/tensorflow_i3_U5005/tensorflow-1.9.0-cp36-cp36m-linux_x86_64.whl
    python -c "import tensorflow as tf; print(tf.__version__)"

    cd kwtf
    mkdir src
    
    msg "FINISHED - Installing Tensorflow"

    msg "Installing Keras"

    pip install keras
    
    msg "FINISHED - Installing Keras"
}

compton_install_configure() {
    msg "Configuring Compton"

    cd $bkp_dir

    mkdir -p ~/.config/compton
    
    cp ./compton/compton.conf ~/.config/compton/compton.conf

    msg "FINISHED - Configuring Compton"
}

urxvt_configure() {
    msg "Configuring URXVT"

    cp $bkp_dir/urxvt/.Xdefaults ~/

    mkdir -p ~/.urxvt/ext
    cp $git_dir/urxvt-resize-font/resize-font ~/.urxvt/ext

    msg "FINISHED - Configuring URXVT"
}

mpv_configure() {
    msg "Configuring MPV"

    msg "Upgrading youtube-dl"
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl

    msg "FINISHED - Configuring MPV"
}

ranger_configure() {
    msg "Configuring Ranger"

    ranger --copy-config=all

    msg "FINISHED - Configuring Ranger"
}

xorg_configure() {
    msg "Configuring XORG"
    
    cp $bkp_dir/xorg/.Xresources ~/
    xrdb ~/.Xresources

    # echo "# Apply hidpi scaling" >> ~/.xinitrc
    # echo "xrdb ~/.Xresources" >> ~/.xinitrc

    echo "# Prevent Xorg from turning off" >> ~/.xinitrc
    echo "xset s off -dpms" >> ~/.xinitrc

    echo "# Disable bell" >> ~/.xinitrc
    echo "xset -b" >> ~/.xinitrc
    
    msg "FINISHED - Configuring XORG"
}

bashmount_install() {
    msg "Installing Bashmount"

    cd $git_dir/bashmount

    sudo install -m755 bashmount /usr/bin/bashmount
    sudo install -m644 bashmount.conf /etc/bashmount.conf

    mkdir -p $HOME/.config/bashmount/
    
    sudo install -m644 bashmount.conf $HOME/.config/bashmount/config

    if [ ! -e bashmount.1.gz ]; then
	gzip -9 bashmount.1
    fi
    
    sudo install -m644 bashmount.1.gz /usr/share/man/man1/bashmount.1.gz

    echo "# Alias for bashmount" >> ~/.bashrc
    echo "alias bm='bashmount'" >> ~/.bashrc

    msg "FINISHED - Installing Bashmount"
}

emacs_configure() {
    msg "Configuring Emacs"

    cp $bkp_dir/emacs_stuff/.emacs ~/
    cp -r $bkp_dir/emacs_stuff/.emacs.d/ ~/

    mkdir -p ~/bin/
    
    cp $bkp_dir/emacs_stuff/Emacs ~/bin/

    msg "FINISHED - Configuring Emacs"
}

emacs_packages() {
    msg "Setting up Elpy"
    
    pip install jedi flake8 autopep8

    msg "FINISHED Setting up Elpy"

    msg "Setting up pdf-tools dependencies"

    sudo apt install –no-install-recommends make automake autoconf g++ gcc \
	 libpng-dev zlib1g-dev \
	 libpoppler-glib-dev \
	 libpoppler-private-dev \
	 imagemagick -y

    msg "FINISHED Setting up pdf-tools dependencies"
}

misc() {
    msg "Copying other stuff"

    echo "exec i3" >> ~/.xinitrc

    mkdir -p ~/.local/share/fonts
    cp $bkp_dir/fonts/* ~/.local/share/fonts/
    
    msg "FINISHED - Copying other stuff"
}

set_wallpaper() {
    msg "Setting wallpaper"

    mkdir -p ~/Pictures/
    cp $bkp_dir/wallpaper.jpg ~/Pictures/

    msg "FINISHED - Setting wallpaper"
}

light_configure() {
    msg "Configuring brightness controlls"

    cd $git_dir/light
    ./autogen.sh
    ./configure && make
    sudo make install

    msg "FINISHED - Configuring brightness controlls"
}

tear_freeness() {
    msg "Setting up tear free ness for intel gpus"

    sudo cp ./xorg/xorg.conf /etc/X11

    msg "FINISHED - Setting up tear free ness for intel gpus"
}

bash_config() {
    msg "Configuring bash"
    
    echo "Ranger default editor" >> ~/.bashrc
    echo "VISUAL='emacsclient -a \"\" -c'; export VISUAL EDITOR='emacsclient -a \"\" -c'; export EDITOR" >> ~/.bashrc

    msg "FINISHED - Configuring bash"
}

build_i3() {
    i3_deps
    i3_build_install
    i3_configure
}

build_polybar() {
    polybar_deps
    polybar_install
    polybar_configure
}

i3status_config() {
    msg "Configuring i3status"

    mkdir -p ~/.config/i3status/
    cp $bkp_dir/i3status/i3status.conf ~/.config/i3status/config

    msg "FINISHED - Configuring i3status"
}

i3blocks_config() {
    msg "Configuring i3blocks"

    mkdir -p ~/.config/i3blocks/
    cp $bkp_dir/i3status/config ~/.config/i3blocks/config

    msg "FINISHED - Configuring i3blocks"
}

install_nvm() {
    cd ~/.nvm
    git checkout v0.35.3

    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bashrc
}

install_yarn() {
    source ~/.bashrc
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install –no-install-recommends yarn -y
}

copy_bin() {
    mkdir ~/bin
    cp $bkp_dir/bin/* ~/bin/

    echo "export PATH=/sbin:$PATH" >> ~/.bashrc
    echo "export PATH=/usr/sbin:$PATH" >> ~/.bashrc
    echo "export PATH=/usr/local/sbin:$PATH" >> ~/.bashrc
    echo "export PATH=/home/dominik/bin:$PATH" >> ~/.bashrc
}

main() {
    # upgrade_system

    # install_base_software

    # clone_repos

    # build_i3

    # compton_install_configure

    # urxvt_configure

    # mpv_configure

    # ranger_configure 

    # xorg_configure

    # bashmount_install

    # set_wallpaper

    # misc

    # tear_freeness

    # i3status_config

    # i3blocks_config

    # copy_bin

    # install_nvm

    # install_yarn

    # add_deb_packages
}
main
