# -*- mode: ruby -*-
# vi: set ft=ruby :

#Todo list
#. 1. Provision Java

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

VAGRANTFILE_API_VERSION = "2"

$vm_script  = <<-SCRIPT
sudo apt-get update
sudo apt-get install -y git vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
SCRIPT

$hosts_script = <<-SCRIPT
echo "10.0.0.1 server server.silkstyle.com" >> /etc/hosts
echo "10.0.0.2 server1 server1.silkstyle.com" >> /etc/hosts
echo "10.0.0.3 server2 server2.silkstyle.com" >> /etc/hosts
echo "10.0.0.4 server3 server3.silkstyle.com" >> /etc/hosts
echo "10.0.0.10 chef chef.silkstyle.com" >> /etc/hosts
echo "10.0.0.11 chef12 chef12.silkstyle.com" >> /etc/hosts
SCRIPT

misc_dir       = "works/misc"

bootstrap_url  = "https://raw.githubusercontent.com/tieli/dotfiles/master/bootstrap.sh"
install_ruby   = "https://raw.githubusercontent.com/tieli/dotfiles/master/install_ruby.sh"
install_rvm    = "https://raw.githubusercontent.com/tieli/dotfiles/master/install_rvm.sh"
fetch_rcfiles  = "https://raw.githubusercontent.com/tieli/dotfiles/master/fetch_dotfiles.sh"

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
    svr.ssh.port = 2200

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

    svr.vm.network :forwarded_port, guest: 22, host: 2210, auto_correct: false, id: "ssh"
    svr.ssh.port = 2210

    guest_ports = [3000, 4567, 5000, 8000, 8080] #3000/rails 4567/sinatra 5000/flask 8000/django
    guest_ports.each do |guest_port|
      host_port = guest_port + index * 10000
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    # svr.vm.provision :chef_solo do |chef|
    #   chef.cookbooks_path = "chef-repo/cookbooks"
    #   chef.add_recipe "apache2"
    # end

    svr.vm.provision :shell, inline: $vm_script
    svr.vm.provision :shell, inline: $hosts_script

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

    svr.vm.network :forwarded_port, guest: 22, host: 2220, auto_correct: false, id: "ssh"
    svr.ssh.port = 2220

    guest_ports = [3000, 4000, 4567, 5000, 8000, 8080]
    guest_ports.each do |guest_port|
      host_port = guest_port + index * 10000
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    # svr.vm.provision :shell, path: bootstrap_url, privileged: false
    svr.vm.provision :shell, path: fetch_rcfiles, privileged: false

    #
    # svr.vm.provision :chef_solo do |chef|
    #   chef.channel = "stable"
    #   chef.version = "12.10.24"
    #   chef.cookbooks_path = "chef-repo/cookbooks"
    #   chef.add_recipe "apache2"
    #  end

    #svr.vm.provision :shell, inline: $hosts_script

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
    svr.ssh.port = 2230

    guest_ports = [3000, 4000, 4567, 5000, 8000, 8080]
    guest_ports.each do |guest_port|
      host_port = guest_port + index * 10000
      svr.vm.network :forwarded_port, guest: guest_port, host: host_port
    end

    # Dir.foreach(misc_dir) do |item|
    #   next if item == '.' or item == '..'
    #   svr.vm.provision "file", source: File.join(misc_dir, item), destination: item
    # end

    svr.vm.provision :shell, path: bootstrap_url, privileged: false

    svr.vm.provision :chef_solo do |chef|
      chef.channel = "stable"
      chef.version = "12.10.24"
      chef.cookbooks_path = ["chef-repo/cookbooks", "chef-repo/cookbooks_tli"]
      chef.add_recipe "mysql::server"
      chef.add_recipe "mysql::client"
      chef.add_recipe "apache2"
    end

    #svr.vm.provision :shell, inline: $hosts_script

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
    svr.ssh.port = 2240

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
      chef.json = {
        :mysql => {
          :server_root_password => 'rootpass',
          :server_debian_password => 'debpass',
          :server_repl_password => 'replpass',
          :data_dir => '/var/lib/mysql',
          :port => '3306'
        },
        :user => {
          :password => "$1$b1o.o2AV$jiHA0nIgzpe7SuAl677Vr/",
          :name => "vagrant",
          :uid => "1050",
          :gid => "150",
          :ls_color => true
        }
      }

      #chef.add_recipe "main::default"

    end

    config.vm.provision :shell, path: install_rvm, args: "stable", privileged: false
    config.vm.provision :shell, path: install_ruby, args: "2.2.5 rails 4.2.6", privileged: false
    config.vm.provision :shell, path: install_ruby, args: "2.1.9 rails 4.1.15", privileged: false
    #svr.vm.provision :shell, path: bootstrap_url, privileged: false
    #svr.vm.provision :shell, inline: $hosts_script

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
    svr.ssh.port = 2310

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
    svr.ssh.port = 2320

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
    svr.ssh.port = 2330

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
    web.ssh.port = 2340

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
    db.ssh.port = 2350

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
    web.ssh.port = 2360

    web.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end

  config.vm.define :test do |svr|

    index = 20

    svr.vm.box = "ubuntu/trusty64"
    svr.vm.hostname = "test"

    svr.vm.network :forwarded_port, guest: 22, host: 2410, auto_correct: false, id: "ssh"
    svr.ssh.port = 2410

    svr.vm.provision :shell, path: bootstrap_url, privileged: false

    svr.vm.provision :ansible_local do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.verbose = "vv"
      ansible.sudo = true
    end

    svr.vm.network :public_network, bridge: INTERFACE_NAME
    svr.vm.network :private_network, ip: "10.0.0." + index.to_s

    svr.vm.provider :virtualbox do |vb|
      vb.gui = true
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
    svr.ssh.port = 2420

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
    svr.ssh.port = 2430

    svr.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 2048
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
