

#1.1 Introduction

Back in the old days, building a home lab during your learning experience was tidious task. You had to build the VMs in VMware Workstation or Virtualbox and the configure those VMs individually to get the "desired state". If you made a mistake during the process you had to do everything from scratch. Alot ot time and effort was lost in building these lab environments. This was until I got my hands on Vagrant. This amazing tool makes your life easier and takes care of pulling the OS images and building them. You can possibly add build scripts to configure the OS post installation. I am working on getting myself CKA by the end of ths year and I needed a homelab to which had a master node and couple of worker nodes. In this guide I will walk you through the Vangrantfile that I am using for the lab spinup. 

##1.2 Prerequisites

Make sure you have below installe beforehand:

Vagrant
Virtualbox

You can run git clone to create the clone of this repository locally:

git clone 

###1.2 Vagratfile

Vagrantfile that we are using 
Vagrantfile for this takes couple of values as a variable that matches your Virtualbox setup and your desired number of worker nodes:
NUM_WORKER_NODE = 4
IP_NW = "192.168.56."
NODE_IP_START = 20

These are the default values and can be modifed to match your needs. Vagrant takes these variables and loops through these values to build the environment. The image that we have specified is:

config.vm.box = "ubuntu/bionic64"




