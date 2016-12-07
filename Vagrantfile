# -*- mode: ruby -*-
# vi: set ft=ruby :

#Todo list
#. 1. Provision Java

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

VAGRANTFILE_API_VERSION = "2"

$vm_script  = <<-SCRIPT

sudo apt-get update
sudo apt-get install -y git vim build-essential libssl-dev libffi-dev python-dev

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#mkdir -p ~/.vim/autoload && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

vim_rc_url="https://raw.githubusercontent.com/tieli/dotfiles/master/.vimrc"
wget -N -P $HOME $vim_rc_url

vim +PluginInstall +qall

ln -s /vagrant/works ~/works

wget https://bootstrap.pypa.io/get-pip.py
sudo python ~/get-pip.py
sudo pip install virtualenv
sudo pip install ansible
sudo pip install pexpect

SCRIPT

# Install chef, this needs be run in previledge mode
$chef_script  = <<-SCRIPT
curl -L https://www.opscode.com/chef/install.sh | bash
SCRIPT

user_json = {
  :group => {
    :name => "tli",
    :gid => "1002"
  },
  :user => {
    :password => "$1$Gc0f84N8$2OZRFIMW.jsFXfyY1OkuL/", #theplaintextpassword
    :name => "tli",
    :uid => "1002",
    :gid => "1002",
    :shell => "/bin/bash",
    :ls_color => true
  }
}

bootstrap_url  = "https://raw.githubusercontent.com/tieli/dotfiles/master/bootstrap.sh"
install_ruby   = "https://raw.githubusercontent.com/tieli/dotfiles/master/install_ruby.sh"
install_rvm    = "https://raw.githubusercontent.com/tieli/dotfiles/master/install_rvm.sh"

INTERFACE_NAME = "Qualcomm Atheros AR9485WB-EG Wireless Network Adapter"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "server" do |svr|

    index = 1

    svr.vm.box = "hashicorp/precise32"
    svr.vm.hostname = "server"
    svr.vm.provision :shell, path: bootstrap_url, privileged: false

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2200, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    guest_ports = [3000, 4000, 4567, 5000, 8000, 8080]
    guest_ports.each do |guest_port|
      host_port = guest_port + 10000
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 512
    end
  end

  config.vm.define :server1, :primary => true do |svr|

    index = 2
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "server1"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    ssh_port = 2200 + (index-1) * 10
    svr.vm.network :forwarded_port, guest: 22, host: ssh_port, auto_correct: false, id: "ssh"
    svr.ssh.port = ssh_port
    svr.ssh.forward_agent = true
    svr.ssh.forward_x11 = true

    guest_ports = [3000, 4567, 5000, 8000, 8080, 9292] #3000/rails 4567/sinatra 5000/flask 8000/django
    guest_ports.each do |guest_port|
      host_port = guest_port + (index / 6 + 1) * 10000 + (index % 10)
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    svr.omnibus.chef_version = "12.10.24"

    svr.berkshelf.berksfile_path = "chef-repo/Berksfile"
    svr.berkshelf.enabled = true

    svr.vm.provision :chef_solo do |chef|
      chef.json = user_json
      chef.run_list = [
            "recipe[main::default]",
            "recipe[main::package]",
      ]
    end

    svr.vm.provision :shell, path: bootstrap_url, privileged: false
    svr.vm.provision :shell, path: install_rvm, args: "stable", privileged: false
    svr.vm.provision :shell, path: install_ruby, args: "2.2.5 rails 4.2.6", privileged: false
    svr.vm.provision :shell, path: install_ruby, args: "2.1.9 rails 4.2.6", privileged: false

    svr.vm.provision :shell, inline: $vm_script, privileged: false

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 1024
    end
  end

  config.vm.define :server2 do |svr|

    index = 3
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "server2"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    ssh_port = 2200 + (index-1) * 10
    svr.vm.network :forwarded_port, guest: 22, host: ssh_port, auto_correct: false, id: "ssh"
    svr.ssh.port = ssh_port

    guest_ports = [80, 3000, 4000, 4567, 5000, 8000, 8080]
    guest_ports.each do |guest_port|
      host_port = guest_port + (index / 6 + 1) * 10000 + (index % 10)
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    svr.omnibus.chef_version = "12.10.24"

    svr.berkshelf.berksfile_path = "chef-repo/Berksfile"
    svr.berkshelf.enabled = true

    svr.vm.provision :chef_solo do |chef|
      chef.json = user_json

      # or
      # chef.add_recipe "main::default"
      # chef.add_recipe "main::package"

      chef.run_list = [
            "recipe[main::default]",
            "recipe[main::package]",
            #"recipe[main::database]",
            #"recipe[main::web]",
      ]

    end

    svr.vm.provision :shell, path: bootstrap_url, privileged: false
    svr.vm.provision :shell, path: install_rvm, args: "stable", privileged: false
    svr.vm.provision :shell, path: install_ruby, args: "2.2.5 rails 4.2.6", privileged: false
    svr.vm.provision :shell, path: install_ruby, args: "2.1.9 rails 4.2.6", privileged: false

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 1024
    end
  end

  config.vm.define :server3 do |svr|

    index = 4
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "server3"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2230, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    guest_ports = [3000, 4000, 4567, 5000, 8000, 8080]
    guest_ports.each do |guest_port|
      host_port = guest_port + index * 10000
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    svr.omnibus.chef_version = "12.10.24"

    svr.berkshelf.berksfile_path = "chef-repo/Berksfile"
    svr.berkshelf.enabled = true

    svr.vm.provision :chef_solo do |chef|
      chef.json = user_json

      chef.run_list = [
            "recipe[main::default]",
            "recipe[main::package]",
            "recipe[main::database]",
            "recipe[main::web]",
      ]

     end

    svr.vm.provision :shell, path: bootstrap_url, privileged: false
    svr.vm.provision :shell, path: install_rvm, args: "stable", privileged: false
    svr.vm.provision :shell, path: install_ruby, args: "2.2.5 rails 4.2.6", privileged: false
    svr.vm.provision :shell, path: install_ruby, args: "2.1.9 rails 4.2.6", privileged: false

     svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 512
    end
  end

  config.vm.define :server4 do |svr|

    index = 5
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "server4"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2240, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    guest_ports = [3000, 4000, 4567, 5000, 8000, 8080]
    guest_ports.each do |guest_port|
      host_port = guest_port + index * 10000
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    # Dir.foreach(misc_dir) do |item|
    #   next if item == '.' or item == '..'
    #   svr.vm.provision "file", source: File.join(misc_dir, item), destination: item
    # end

    svr.omnibus.chef_version = "12.10.24"

    svr.berkshelf.berksfile_path = "chef-repo/Berksfile"
    svr.berkshelf.enabled = true

    svr.vm.provision :chef_solo do |chef|
      chef.json = user_json
      chef.add_recipe "main::default"

    end

    config.vm.provision :shell, path: install_rvm, args: "stable", privileged: false
    config.vm.provision :shell, path: install_ruby, args: "2.2.5 rails 4.2.6", privileged: false
    config.vm.provision :shell, path: install_ruby, args: "2.1.9 rails 4.1.15", privileged: false
    svr.vm.provision :shell, path: bootstrap_url, privileged: false

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 512
    end
  end

  config.vm.define :chef do |svr|

    index = 10
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "chef"

    svr.vm.network :public_network, bridge: INTERFACE_NAME, ip:"172.18.70.143"
    svr.vm.network :private_network, :ip => "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2310, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 2048
    end
  end

  config.vm.define :chef12 do |svr|

    index = 11
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "chef12"

    svr.vm.network :public_network, bridge: INTERFACE_NAME, ip:"172.18.70.143"
    svr.vm.network :private_network, :ip => "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2320, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 2048
    end
  end

  config.vm.define :ubuntu14 do |svr|

    index = 12
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "ubuntu14"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, :ip => "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2330, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    svr.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "chef-repo/cookbooks"
      chef.add_recipe "apache2"
      chef.add_recipe "main"
    end

    svr.vm.provision :shell, inline: $vm_script

    svr.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.memory = 1024
    end
  end

  config.vm.define :centos65 do |web|

    index = 13
    web.vm.box = "chef/centos-6.5"
    web.vm.hostname = "centos65"

    web.vm.network :public_network, bridge: INTERFACE_NAME
    web.vm.network :private_network, :ip => "10.0.0." + index.to_s

    web.vm.network :forwarded_port, guest: 22, host: 2340, auto_correct: false, id: "ssh"
    web.ssh.port = 2200 + index * 10

    web.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "chef-repo/cookbooks"
      chef.add_recipe "apache2"
      chef.add_recipe "main"
    end

    web.vm.provision :shell, inline: $vm_script

    web.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end

  config.vm.usable_port_range = 2200..2250

  config.vm.define :db do |db|

    index = 14

    db.vm.box = "hashicorp/precise32"
    db.vm.provision :shell, path: bootstrap_url

    db.vm.hostname = "db"

    db.vm.network :public_network, bridge: INTERFACE_NAME
    db.vm.network :private_network, :ip => "10.0.0." + index.to_s

    db.vm.network :forwarded_port, guest: 22, host: 2350, auto_correct: false, id: "ssh"
    db.ssh.port = 2200 + index * 10

    db.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end

  config.vm.define :web do |web|

    index = 15
    web.vm.box = "chef/centos-6.5"
    web.vm.hostname = "web"
    web.vm.network :forwarded_port, guest: 80, host: 11080

    web.vm.network :public_network, bridge: INTERFACE_NAME
    web.vm.network :private_network, :ip => "10.0.0." + index.to_s

    web.vm.network :forwarded_port, guest: 22, host: 2360, auto_correct: false, id: "ssh"
    web.ssh.port = 2200 + index * 10

    web.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end

  config.vm.define :test do |svr|

    index = 20

    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "test"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    ssh_port = 2200 + (index-1) * 10
    svr.vm.network :forwarded_port, guest: 22, host: ssh_port, auto_correct: false, id: "ssh"
    svr.ssh.port = ssh_port

    guest_ports = [3000, 4567, 5000, 8000, 8080, 9292] #3000/rails 4567/sinatra 5000/flask 8000/django
    guest_ports.each do |guest_port|
      host_port = guest_port + (index / 6 + 1) * 10000 + (index % 10)
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    svr.vm.provision :shell, inline: $vm_script, privileged: false
    svr.vm.provision :shell, path: $chef_script

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 512
    end
  end

  config.vm.define :saltstack do |svr|

    index = 21
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "saltstack"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, :ip => "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2420, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 2048
    end
  end

  config.vm.define :docker do |svr|

    index = 22
    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "docker"

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, :ip => "10.0.0." + index.to_s

    svr.vm.network :forwarded_port, guest: 22, host: 2430, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 2048
    end
  end

  config.vm.define :test1 do |svr|

    index = 23

    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "test1"

    svr.vm.network :forwarded_port, guest: 22, host: 2440, auto_correct: false, id: "ssh"
    svr.ssh.port = 2200 + index * 10

    #svr.vm.provision :shell, path: bootstrap_url, privileged: false

    # svr.vm.provision :ansible_local do |ansible|
    #   ansible.playbook = "playbook.yml"
    #   ansible.verbose = "vv"
    #   ansible.sudo = true
    # end

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    svr.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.memory = 512
    end
  end


  config.vm.define :laravel do |svr|

    index = 24

    svr.vm.box = "laravel/homestead"

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 1024
    end

  end

  vms = [
    {"box" => "ubuntu/trusty64", "memory" => 512, "gui" => false},
    {"box" => "ubuntu/trusty64", "memory" => 512, "gui" => false},
    {"box" => "chef/centos-6.5", "memory" => 512, "gui" => false},
    {"box" => "chef/centos-6.5", "memory" => 512, "gui" => false},
    {"box" => "centos-7.0", "memory" => 512,	"gui" => false},
    {"box" => "centos-7.0", "memory" => 512,	"gui" => false},
    {"box" => "ubuntu14", "memory" => 512,	"gui" => false},
    {"box" => "hashicorp/precise32", "memory" => 512,	"gui" => false}
  ]

  offset = 10

  vms.each_with_index do |item, i|

    vm_num = i + offset
    server_name = "server" + vm_num.to_s

    guest_port  = 2500 + vm_num

    config.vm.define server_name do |svr|

      svr.vm.box = item["box"]
      svr.vm.hostname = server_name

      $script = <<-SCRIPT
      echo "10.0.0.5 chef chef.silkstyle.com" >> /etc/hosts
      SCRIPT
      svr.vm.provision :shell, inline: $script

      svr.vm.network :public_network, bridge: INTERFACE_NAME
      svr.vm.network :private_network, ip: "10.0.0." +  (vm_num + 100).to_s

      svr.vm.network :forwarded_port, guest: 22, host: guest_port, auto_correct: false, id: "ssh"
      svr.ssh.port = guest_port

      svr.vm.provider :virtualbox do |vb|
        vb.gui = item["gui"]
        vb.memory = item["memory"]
      end
    end
  end

end
