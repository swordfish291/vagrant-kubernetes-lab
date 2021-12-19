# Spin Kubernetes Lab with Vagrant
## 1.1 Introduction

Back in the old days, building a home lab to support your learning was tidious task. You had to build the VMs in VMware Workstation or Virtualbox and the configure those VMs individually to get the "desired state". If you made a mistake during the process you had to do everything from scratch. Alot ot time and effort was lost in building these lab environments. This was the case for me until I got my hands on Vagrant. This amazing tool makes your life easier and takes care of pulling the OS images and building them. You can add build scripts to configure the OS post installation. I am working on getting myself CKA by the end of ths year and I needed a homelab which had a master node and couple of worker nodes. In this guide I will walk you through the Vagrantfile that I am using for the lab spinup. 

## 1.2 Prerequisites

Make sure you have below installed beforehand:

[Vagrant](https://www.vagrantup.com/downloads)

[Virtualbox](https://www.virtualbox.org/wiki/Downloads)

You can run git clone to create the clone of this repository locally:

```
git clone https://github.com/swordfish291/vagrant-kubernetes-lab.git
```

## 1.3 Vagrant Up
You can run git clone to create the clone of this repository locally:
```
git clone https://github.com/swordfish291/vagrant-kubernetes-lab.git
```

![image](https://user-images.githubusercontent.com/25719157/146688319-d5b6ef90-5163-4173-b1af-3ea241d36301.png)

Navigate to the directory and run:
```
vagrant up
```
![image](https://user-images.githubusercontent.com/25719157/146688405-f4cd1c6b-5a88-4a93-a2f2-2c488c76b059.png)

Once the cluster is up, you can run ```vagrant status``` to check the status of the VMs:

![image](https://user-images.githubusercontent.com/25719157/146688553-bdb28e87-7d4a-4694-a7c7-8708fe581a0b.png)

Now you can ssh to the master node using ```vagrant ssh k8s-master``` 

![image](https://user-images.githubusercontent.com/25719157/146688599-97af4aff-8b00-4d42-8645-0522c0cf5a24.png)

Now you can run ```kubectl get nodes``` to check the status of the nodes:
![image](https://user-images.githubusercontent.com/25719157/146688648-0711a943-aaa8-408a-846f-690ae3b66cef.png)

Cluster is ready. You can start hacking !
## 1.3 Vagrantfile

### Variables
Vagrantfile for this takes couple of values as a variable that matches your Virtualbox setup and your desired number of worker nodes:
```
NUM_WORKER_NODE = 4
```

```
IP_NW = "192.168.56."
```

```
NODE_IP_START = 20
```

These are the default values and can be modifed to match your needs. Vagrant takes these variables and loops through these values to build the environment. The image that we have specified is:

config.vm.box = "ubuntu/bionic64"

### Provisioing Scripts
There are three provisioning scripts that are being used to prepare the master and worker nodes. One script is prepared as part of the build process to join the worker nodes to the control plane. 

#### - setup-network.sh
This script prepares all the nodes for network. It adds the host entries and modifes the DNS server settings. If you are planning to use more than 4 worker nodes, you will need to modify below section and add the additional host entries for the additioal worker nodes:
``` bash
cat >> /etc/hosts <<EOF
192.168.5.10  k8s-master
192.168.5.21  k8s-worker-1
192.168.5.22  k8s-worker-2
EOF
```
#### - master-prep.sh
This script installs the required packages and botstraps the control plane components. Once the cluster is initialized, it prepares the join string for the worker nodes to prevent manual intervention. You can modify the last part of this script suit your needs for pod network.


#### - worker-prep.sh
This script installs the required packages to the worker nodes and uses the joinstring.sh script to join the worker nodes to the initialized cluster. 





