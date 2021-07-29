# Basic setup of debian vm to use locally

# use vim rather than nano
update-alternatives --set editor /usr/bin/vim.basic

# Allow running sudo without password
echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

#create user nathan
adduser --disabled-password nathan

# Allow ssh
mkdir /home/nathan/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWZN8F5IzLRDcAiku79zRVBjJ6TB+jxmK84vJ+cJ5rbFI4hEbDmx28bwA6etuOJ4DvqRFhMfAZcItx+C4PBZDm0DYvtlYdcjwszGGSZjJ9MW1YqvpyRKnprNXzTAzo8zyQTHWSeu9N03V8uDDJ3l7F+yOswKasC/l0hLOlzUEOWkU5vd1ngLsNmSf++TthWfRQ8vewedzGSxIYB0rLiaU5mi24x72VF040L4xhfPnlL4jSokunXJsVbEq9juD752x1roiZZUsrpT+3QPSqi0bkescWWNHnIh4Gugsq2a6pWid9h8Yb/wm2D7rS/PaexY4WQyQcRD5Hyic1T20ltE79 jhaveri@Nathans-MacBook-Air.local" >> /home/nathan/.ssh/authorized_keys

chown -R nathan:nathan /home/nathan/.ssh
chmod 700 /home/nathan/.ssh
chmod 600 /home/nathan/.ssh/authorized_keys

echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

## Can login as nathan here

# install basics
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y \
    curl \
    git \
    build-essential \
    gdb \
    strace \
    htop \
    libssl-dev \ # openssl libraries
    pkg-config   # so rust can find openssl

# Setup github ssh key
ssh-keygen -t ed25519 -C "jhaveri@umich.edu"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo "copy ssh pub key to github now"
cat ~/.ssh/id_ed25519.pub

# Setup git
git config --global user.email "jhaveri@umich.edu"
git config --global user.name "Nathan Jhaveri"
git config --global init.defaultBranch main

#install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install cargo-edit
