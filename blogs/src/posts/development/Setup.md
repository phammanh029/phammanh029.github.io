# This contains the setup for linux machine for dev (typescript) + devops
```
sudo apt update
sudo apt install -y \
  build-essential curl wget git unzip zip ca-certificates gnupg lsb-release \
  jq yq ripgrep fd-find fzf \
  htop btop tmux \
  net-tools dnsutils iputils-ping traceroute nmap \
  openssh-client openssh-server \
  python3 python3-pip

```
## fonts
```
sudo apt install -y zsh fonts-firacode
```
## Git config
```
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global fetch.prune true
git config --global core.autocrlf input
```

## Nodejs
```
curl -fsSL https://bun.sh/install | bash
# restart shell
bun -v
```

## eslint
```
npm i -g typescript ts-node eslint prettier
```

## Dockers

```
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl status docker
sudo systemctl start docker
sudo groupadd docker
newgrp docker
```

## Install helm
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
sudo snap install k9s --classic
```

## install k3d
```
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d version
```

## install terraform
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update

```

## Slack
```
sudo snap install slack
```

## Ubuntu
```
sudo add-apt-repository ppa:ubuntu-vn/ppa
sudo apt-get update
sudo apt-get install ibus-unikey
ibus restart
```

## NVM
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
exec $SHELL
nvm install --lts
nvm use --lts
nvm alias default lts/*
echo '
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "$nvmrc_path")")
    [ "$nvmrc_node_version" = "N/A" ] && nvm install
    nvm use
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
' >> ~/.zshrc

```

## Htop
`sudo apt install -y htop`

## Oh myzsh
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Edit ~/.zshrc
```bash
plugins=(
  git
  docker
  docker-compose
  kubectl
  helm
  terraform
  npm
  node
  sudo
  history
  colored-man-pages
)
```


# Setup github account
```
ssh-keygen -t ed25519 -C manh.pham@codeleap.de
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## The fuck
```
sudo apt install thefuck
```