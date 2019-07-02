# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :otuslinux => {
        :box_name => "centos/7",
        :ip_addr => '172.20.10.50',
		},
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|

          box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

          box.vm.network "private_network", ip: boxconfig[:ip_addr]

          box.vm.provider :virtualbox do |vb|
            	  vb.customize ["modifyvm", :id, "--memory", "512"]
            	  vb.customize ["modifyvm", :id, "--cpus", "1"]
                  needsController = false
		  end
 	  box.vm.provision "shell", inline: <<-SHELL
	      mkdir -p ~root/.ssh
              cp ~vagrant/.ssh/auth* ~root/.ssh
        yum install -y epel-release
        yum install -y vim
        yum install -y ShellCheck
        curl -o /etc/pam.sh https://raw.githubusercontent.com/didaktikm/pam/master/pam.sh # Загружаем скрипт проверки
        curl -o /etc/holidays https://raw.githubusercontent.com/didaktikm/pam/master/holidays # файл с праздниками
        sed -i "7i account     required       pam_exec.so    /etc/pam.sh" /etc/pam.d/sshd # Добавляем необходимость проверки условия в скрипте
        chmod +x /etc/pam.sh # Делаем скрипт исполняемым
        groupadd admin # Добавляем группу
        usermod -G admin vagrant # Добавляем пользователей в группу
        useradd -G admin didaktik
        echo 0000 | passwd didaktik --stdin # Задаем пароли
        useradd speccy
        echo 0000 | passwd speccy --stdin
        #curl -o /root/.vimrc https://raw.githubusercontent.com/didaktikm/vimconf/master/.vimrc
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config  # Разрешаем вход по паролю
        systemctl restart sshd

  	  SHELL

	  #config.vm.provision "shell", path: "./provision.sh"

      end
  end
end
