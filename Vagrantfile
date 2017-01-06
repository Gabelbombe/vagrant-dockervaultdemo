# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "postgres" do |v|
    v.vm.provider "docker" do |d|
      d.name = "db"
      d.image = "postgres"
      d.volumes = ["/var/docker/postgresql:/var/lib/postgresql/data"]
      d.ports = ["5432:5432"]
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

  config.vm.define "vault" do |v|
    v.vm.provider "docker" do |d|
      d.name = "vault"
      d.image = "cgswong/vault"
      d.volumes = ["/var/docker/vault:/vault"]
      d.ports = ["8200:8200"]
      d.link("db:db")
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
      d.cmd = ["server", "-config=/vagrant/vault.hcl"]
      d.create_args = ["--cap-add", "IPC_LOCK"]
    end
  end

  config.vm.define "vaultclient" do |v|
    v.vm.provider "docker" do |d|
      d.image = "cgswong/vault"
      d.link("vault:vault")
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
      d.cmd = ["init"]
      d.remains_running = false
      d.env = {
        "VAULT_ADDR" => "http://vault:8200"
      }
    end
  end
end
