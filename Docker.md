# Docker Related Solutions

## Can’t start containers with GPU access on Linux
Only Docker Desktop for Windows supports GPUs when the WSL2 backend is used, since WSL2 supports GPUs. Otherwise you have a virtual machine without GPUs. So Docker Desktop for Linux does not support it, but on Linux, you can install Docker CE which does.By using VSCode and the Docker plugin we can manage the containers.

- Uninstalled Docker Desktop completely before installing Docker CE
```sh
sudo apt remove docker-desktop
sudo apt purge docker-desktop
sudo rm -rf ~/.docker #plus any other places there's docker config
```
- Removed any leftover packages that weren’t used elsewhere, just in case
```sh
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
```
Manually removed Docker’s network settings by removing the relevant configurations, basically any daemon.json files that were hanging around my system.
- Installed Docker CE with these commands
```sh
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
(“noble” is my `UBUNTU_CODENAME` from `/etc/os-release`)
(The first apt install here might not be necessary but it was the steps I followed)

- Followed the instructions once again at [Nvidia’s toolkit install steps](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt)
- Ran the sample workload
```sh
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

## If `/usr/local/bin/docker` file not found
```sh
sudo ln -s /usr/bin/docker /usr/local/bin/docker
```

## Add my user to the docker group
Ensure the docker group exists.
```sh
sudo groupadd docker
```
Add your user to the `docker` group
```sh
sudo usermod -aG docker $USER
```
The following command will activate the new group membership for your current session. 
```sh
newgrp docker
```
You can verify that your user is now part of the docker group by running:
```sh
groups $USER
```