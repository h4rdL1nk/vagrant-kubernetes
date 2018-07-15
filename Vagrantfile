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
      :os => "ubuntu",
      :master_ip => "192.168.77.10"
    },
    "kubecluster-03" => {
      :ip => "192.168.77.12",
      :role => "worker",
      :os => "ubuntu",
      :master_ip => "192.168.77.10"
    },
    "kubecluster-04" => {
      :ip => "192.168.77.13",
      :role => "worker",
      :os => "ubuntu",
      :master_ip => "192.168.77.10"
    }
}

$master_init = <<SCRIPT
sudo kubeadm init --apiserver-advertise-address $1 --pod-network-cidr 10.12.0.0/16 --service-cidr 10.24.0.0/16 --token 8xrb4r.g7vfbkoxn21p8kru --token-ttl 0
sleep 5
mkdir ~/.kube && sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config && sudo chown $(id -u):$(id -g) ~/.kube/config
sleep 2
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
SCRIPT

$node_init = <<SCRIPT
sudo kubeadm join $1:6443 --token 8xrb4r.g7vfbkoxn21p8kru --discovery-token-unsafe-skip-ca-verification
SCRIPT

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
                machine.vm.provision "shell", privileged: false, inline: $master_init, args: "#{attrs[:ip]}"
            elsif attrs[:role] == "worker"
                machine.vm.provision "shell", privileged: false, inline: $node_init, args: "#{attrs[:master_ip]}"
            end
        end
    end
end
