# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = {
    "kubecluster-01" => {
      :ip => "192.168.77.10",
      :role => "master",
      :os => "ubuntu"
    }, 
    "kubecluster-02" => {
      :ip => "192.168.77.11",
      :role => "worker",
      :os => "ubuntu"
    },
    "kubecluster-03" => {
      :ip => "192.168.77.12",
      :role => "worker",
      :os => "ubuntu"
    },
    "kubecluster-04" => {
      :ip => "192.168.77.13",
      :role => "worker",
      :os => "ubuntu"
    }
}

boxes = {
    "ubuntu" => "ubuntu/xenial64",
    "centos" => "centos/7"
}

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.ssh.forward_agent = true
    check_guest_additions = false
    functional_vboxsf     = false
    hosts.each do |name, attrs|
        config.vm.define name do |machine|
            machine.vm.box = boxes[attrs[:os]]
            machine.vm.hostname = name
            machine.vm.network :private_network, ip: attrs[:ip]
            machine.vm.provider "virtualbox" do |v|
                v.name = name
                v.memory = 1024
                v.cpus = 1
                #v.customize ['createhd', '--format', 'VDI', '--filename', docker_disk_file, '--size', 10 * 1024]
                #v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', docker_disk_file]
            end
            machine.vm.provision "shell", path: "provision/install-deps.sh", args: attrs[:os]
            machine.vm.provision "ansible" do |ansible|
                ansible.playbook = "play.yml"
            end
            if attrs[:role] == "master"
                puts "This is a master node"
            elsif attrs[:role] == "worker"
                puts "This is a worker node"
            end
        end
    end
end
