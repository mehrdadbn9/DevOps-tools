### base on ruby
## init
```bash
vagrant init hashicorp/bionic64```

## base of vagrantfile
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
end
```
## default dir
```bash
Vagrantfile in your Vagrant home directory (defaults to ~/.vagrant.d). This lets you specify some defaults for your system user.
```
<!---
comment goes here
and here
-->

## add
```bash 
 vagrant box add --name my-box /path/to/the/new.box
```

## ssh
```bash 
 vagrant ssh <>
```
## destroy
```bash 
 vagrant destroy
```
## up
```bash 
 vagrant up
```
## shell
### The Vagrant Shell provisioner allows you to upload and execute a script within the guest machine.

```bash 
 Vagrant.configure("2") do |config|
  config.vm.provision "shell",
    inline: "echo Hello, World"
end
```
### options: inline,arg,env,
### external script
```bash 
Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "script.sh"
end

Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "https://example.com/provisioner.sh"
end

Vagrant.configure("2") do |config|
  config.vm.provision "shell",
    inline: "/bin/sh /path/to/the/script/already/on/the/guest.sh"
end

Vagrant.configure("2") do |config|
  config.vm.provision "shell" do |s|
    s.inline = "echo $1"
    s.args   = "'hello, world!'"
  end
end

```
### reload
```bash
vagrant reload --provision
```
### synced_folder
```bash 
Vagrant.configure("2") do |config|
  # other config here

  config.vm.synced_folder "src/", "/srv/website"
end

Vagrant.configure("2") do |config|
  config.vm.synced_folder "src/", "/srv/website", disabled: true
end

config.vm.synced_folder "src/", "/srv/website",
  owner: "root", group: "root"

config.vm.synced_folder ".", "/vagrant", owner: "vagrant",
  group: "vagrant", mount_options: ["uid=1234", "gid=1234"]

```
### network
```bash 
Vagrant.configure("2") do |config|
  # ...
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
```
### Enabling Networks
Networks are automatically configured and enabled after they've been defined in the Vagrantfile as part of the vagrant up or vagrant reload process.


### hostname
```bash 
Vagrant.configure("2") do |config|
  # ...
  config.vm.hostname = "myhost.local"
end
```
### ip
```bash 
Vagrant.configure("2") do |config|
  # ...
  config.vm.hostname = "myhost.local"
  config.vm.network "public_network", ip: "192.168.0.1", hostname: true
  config.vm.network "public_network", ip: "192.168.0.2"
end
```
## provider
### Configuring a specific provider looks like this:
```bash 
Vagrant.configure("2") do |config|
  # ...

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end
end
```
## Overriding Configuration
### Vagrant will use the "bionic64" box by default, but will use "bionic64_fusion" if the VMware Fusion provider is used.
```bash 
 config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end
end
```
## multi-box with one config 
###  NodeType1 is set to 3. In this case, (1..3).each would execute the block of code 3 times, with type1_id taking on the values 1, 2, and 3 in each iteration. This would result in the creation of three virtual machines with names “type11”, “type12”, and “type13”, each with the specified configurations.

```bash
Vagrant.configure(2) do |config|
  config.vm.provision "shell", patlh: "bootstrap.sh"

  NodeType1 = 3
  (1..NodeType1).each do |type1_id|
    config.vm.define "type1#{type1_id}" do |type1_vm|
      type1_vm.vm.box = IMAGE_2204
      type1_vm.vm.hostname = "type1#{type1_id}"
      type1_vm.vm.network "private_network", ip: "192.168.56.10#{type1_id}"
      type1_vm.vm.provider "virtualbox" do |v|
        v.name = "type1#{type1_id}"
        v.memory = 1024
        v.cpus = 1
      end
      type1_vm.vm.provision "shell", path: "bootstrap_t1.sh"
    end
```
### Suppose you change NodeType1 to 2. In that case, the loop (1..NodeType1).each would iterate twice. This would create two virtual machines with the names “type11” and “type12”, each with the specified configurations, and provision them with the “bootstrap_t1.sh” script.

### ENV['VAGRANT_NO_PARALLEL'] = 'yes' line sets an environment variable named VAGRANT_NO_PARALLEL to the value 'yes'. This specific setting tells Vagrant not to run multiple virtual machines in parallel
```bash
ENV['VAGRANT_NO_PARALLEL'] = 'yes'
```
