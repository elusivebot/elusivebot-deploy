# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
set -ex

export DEBIAN_FRONTEND=noninteractive

wget -O /tmp/asdf.tgz https://github.com/asdf-vm/asdf/releases/download/v0.16.7/asdf-v0.16.7-linux-amd64.tar.gz
tar -C /usr/local/bin -zxvf /tmp/asdf.tgz
rm /tmp/asdf.tgz

apt-get update
apt-get upgrade -y
apt-get install -y curl git dirmngr gpg gawk unzip jq ca-certificates graphviz tree silversearcher-ag bat htop unattended-upgrades
apt-get remove -y docker.io docker-doc docker-compose podman-docker containerd runc


sudo -H -u vagrant -i -- <<EOF
  set -ex
  echo 'export PATH="\\${ASDF_DATA_DIR:-\\$HOME/.asdf}/shims:\\$PATH:/vagrant_bin"' >> /home/vagrant/.bash_profile
  echo '. <(asdf completion bash)' >> /home/vagrant/.bash_profile
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin add java https://github.com/halcyon/asdf-java.git
  asdf install nodejs 22.14.0
  asdf install java temurin-17.0.14+7
  asdf set nodejs 22.14.0
  asdf set java temurin-17.0.14+7
EOF

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

mkdir /build
chown vagrant:vagrant /build
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.network "forwarded_port", guest: 8000, host: 8000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8001, host: 8001, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8002, host: 8002, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9092, host: 9092, host_ip: "127.0.0.1"

  config.vm.synced_folder "../", "/elusivebot"
  config.vm.synced_folder "./bin/vagrant", "/vagrant_bin"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision "shell", inline: $script
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
	vb.cpus = 4
  end
  
  config.vm.provider "hyperv" do |h|
    h.memory = 4096
	h.maxmemory = 4096
	h.cpus = 4
  end
end
