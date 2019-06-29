# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :otuslinux => {
        :box_name => "centos/7",
        :ip_addr => '192.168.11.150',
		},
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|

          box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

          box.vm.network "private_network", ip: boxconfig[:ip_addr]

          box.vm.provider :virtualbox do |vb|
            	  vb.customize ["modifyvm", :id, "--memory", "1024"]
            	  vb.customize ["modifyvm", :id, "--cpus", "2"]
                  needsController = false
		  end
 	  box.vm.provision "shell", inline: <<-SHELL
	      mkdir -p ~root/.ssh
              cp ~vagrant/.ssh/auth* ~root/.ssh
        yum install -y epel-release
        yum install -y vim
        yum install -y ShellCheck
        yum install -y pam_script ###
        curl -o /etc/pam-script.d/pam.sh https://raw.githubusercontent.com/didaktikm/pam/master/pam.sh
        sed -i '/1/a auth     required       pam_script.so    dir=/etc/pam-script.d/' /etc/pam.d/sshd
        chmod +x /etc/pam-script.d/pam.sh
        groupadd admin
        useradd -G admin didaktik
        echo 0000 | passwd didaktik --stdin
        useradd speccy
        echo 0000 | passwd speccy --stdin
        #curl -o /root/.vimrc https://raw.githubusercontent.com/didaktikm/vimconf/master/.vimrc
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd

  	  SHELL

	  #config.vm.provision "shell", path: "./provision.sh"

      end
  end
end