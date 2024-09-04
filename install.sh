#!/bin/bash

get_latest_github_release_file() {
    local repo="$1"
    local file_name="$2"

    latest_tag=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | grep '"tag_name":' | cut -d '"' -f 4)
    download_url="https://github.com/${repo}/releases/download/${latest_tag}/${file_name}"

    echo "$download_url"
}

# Give current user sudo nopasswd, no time for sudo while hacking!
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER

sudo apt update && sudo apt upgrade -y

sudo apt-get install -y wget curl git thunar xclip alacritty seclists feroxbuster
sudo apt-get install -y arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson 
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev 
sudo apt-get install -y libstartup-notification0-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-cursor-dev libxcb-keysyms1-dev libxcb-icccm4-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev libpcre2-dev libairo-dev librust-pangocairo-dev libev-dev

mkdir -p ~/.local/share/fonts/

echo "[i] Finding latest version of the JetBrainsMono nerd font..."
nerd_font_url=$(get_latest_github_release_file "ryanoasis/nerd-fonts" "JetBrainsMono.zip")
echo "Downloading JetBrainsMono nerd font from: $nerd_font_url"
wget "$nerd_font_url"

sudo unzip JetBrainsMono.zip -d /usr/local/share/fonts/
sudo fc-cache -fv

git clone https://github.com/i3/i3 i3
cd i3 && mkdir -p build && cd build && meson ..
ninja
sudo ninja install
cd ../..

pip3 install pywal

mkdir -p ~/.config/i3
mkdir -p ~/.config/compton
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
cp .config/i3/config ~/.config/i3/config
cp .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp .config/i3/i3blocks.conf ~/.config/i3/i3blocks.conf
cp .config/compton/compton.conf ~/.config/compton/compton.conf
cp .config/rofi/config ~/.config/rofi/config
cp .fehbg ~/.fehbg
cp .config/i3/clipboard_fix.sh ~/.config/i3/clipboard_fix.sh
cp -r .wallpaper ~/.wallpaper

echo "[i] Setting up tmux..."
cp .config/tmux/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

echo "[i] Downloading zsh aliases..."
git clone https://github.com/jazzpizazz/zsh-aliases.git ~/zsh-aliases
echo "source ~/zsh-aliases/aliases.zsh" >> ~/.zshrc

echo "[+] Done! Grab some wallpaper and run pywal -i filename to set your color scheme. To have the wallpaper set on every boot edit ~.fehbg"
echo "[i] After reboot: Select i3 on login, run lxappearance and select arc-dark"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
sudo reboot now
