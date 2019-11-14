#/bin/bash



mkdir -p /opt/ml/input/data
mkdir -p /opt/ml/output
mkdir -p /opt/ml/input/config
mkdir -p /opt/ml/model
mkdir -p /opt/ml/code/data/pretrain_model
#pip install cython easydict
api install gcc -y
#Install driver
apt install ubuntu-drivers-common -y
ubuntu-drivers autoinstall  

#Install CUDA
#wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
#sudo sh cuda_10.1.243_418.87.00_linux.run
#You could find the CUDA version via 
#https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=runfilelocal


wget https://developer.download.nvidia.cn/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux.run
sudo sh cuda_10.0.130_410.48_linux.run

#https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux

export LD_LIBRARY_PATH="/usr/local/cuda-10.0/lib64"
export CUDA_HOME=/usr/local/cuda-10.0

export PATH=$PATH:/usr/local/cuda-10.1/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64

#ssh -i "DevelopmentKey.pem" ubuntu@ec2-18-140-68-81.ap-southeast-1.compute.amazonaws.com

#for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done
