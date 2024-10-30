How to Set Up Free LXC (Linux Containers) Instances for Learning: A Beginner’s Guide to Using LXD with Proxies for SSH and Web Access
With LXC (Linux Containers) and LXD, you can create multiple virtualized instances on your local machine without paying for cloud servers! This guide walks you through setting up an LXC environment to provision as many instances as you need for learning, all for free. You’ll learn to configure SSH and web server access with proxies so you can connect to your containers securely and manage them effectively.

1. Installing LXD and Initializing It
Start by installing LXD, the tool that helps manage LXC containers, on your local machine.


```snap install lxd
sudo snap install lxd
```
Explanation: LXD acts as a manager for LXC containers. Using sudo allows the installation at a system level.

Once installed, initialize LXD with the following command:

```
lxd init
sudo lxd init
```

Explanation: lxd init sets up LXD with default settings. This process will ask for configurations like networking and storage, but you can accept the defaults if you're new to it.

2. Creating a New Free Container Instance
Now, you can create your first container instance!

```
sudo lxc launch ubuntu:22.04 ubuntu-container
``` 
Explanation: This command creates a new container running Ubuntu 22.04, named ubuntu-container. Feel free to replace ubuntu-container with any name you prefer (e.g., my-learning-instance). With LXC, you can create multiple containers like this without paying for a cloud instance!

3. Listing Containers
To confirm that your container is running, list all active containers:
```
sudo lxc list
``` 
Explanation: This command displays all active containers, along with their IP addresses and states. The IP address will be useful when setting up SSH or other connections.

4. Accessing the Container Directly
To access the container for the first time, use the exec command:

```
sudo lxc exec ubuntu-container bash
```
Explanation: lxc exec ubuntu-container bash opens a shell session inside the container, allowing you to interact with it as though it’s a separate machine.

5. Setting Up SSH Access to the Container
SSH (Secure Shell) provides a secure way to log into the container. Setting up SSH access requires adding an SSH public key to the container.

Understanding SSH Keys
An SSH key pair includes:

Private Key: Stays on your local machine.
Public Key: Copied to the container for access.
Example: SSH keys are commonly used to access remote servers or services securely, such as when pushing code to GitHub.

Adding an Existing SSH Key
If you already have an SSH key pair (e.g., ~/.ssh/id_rsa.pub), you can use it for the container.

Enter the container:

```
sudo lxc exec ubuntu-container bash
```
Navigate to the .ssh folder:

```
cd ~/.ssh
```
Open the authorized_keys file to add your public key:

```
nano authorized_keys
```
Paste your public key (contents of id_rsa.pub). This allows passwordless SSH access to the container.

Note: If the .ssh folder or authorized_keys file doesn’t exist, create them with mkdir ~/.ssh and touch authorized_keys.

Generating a New SSH Key Pair
If you don’t have an SSH key pair, create one with:

```
ssh-keygen -t rsa -b 2048 -f ~/.ssh/my-container-key
```
Explanation:

ssh-keygen generates an SSH key pair.
-t rsa -b 2048 specifies an RSA key of 2048 bits.
-f ~/.ssh/my-container-key names the key files.
Copy the public key to the authorized_keys file in the container.

6. Configuring Proxy and Binding for SSH Access
To allow SSH access to your container from outside, set up a proxy to forward connections from a specific port on your local machine to the container’s SSH port (22).

``` 
sudo lxc config device add ubuntu-container myproxy22 proxy listen=tcp:0.0.0.0:2222 connect=tcp:127.0.0.1:22 bind=host
```
Explanation:

```lxc config device add``` adds a proxy device to ubuntu-container.
```myproxy22``` is the name for this SSH proxy device.
```listen=tcp:0.0.0.0:2222``` listens on port 2222 on all interfaces on your local machine.
```connect=tcp:127.0.0.1:22``` forwards traffic to the container’s port 22 (SSH).
```bind=host ```makes this binding effective on the host machine.
This setup lets you SSH into the container through localhost on port 2222.

7. Setting Up Proxy for Web Server Access (Port 80)
If you’re running a web server (e.g., Apache or Nginx) in the container on port 80, you can configure another proxy to access it through a custom port on your host.

```
sudo lxc config device add ubuntu-container myproxy80 proxy listen=tcp:0.0.0.0:8888 connect=tcp:127.0.0.1:80 bind=host
```
Explanation:

```myproxy80``` is the name of the web proxy device.
```listen=tcp:0.0.0.0:8888``` listens on port 8888 for web traffic.
```connect=tcp:127.0.0.1:80``` forwards this connection to the container’s port 80 (HTTP).
You can access the container’s web server at http://<host-ip>:8888.

8. Connecting to the Container via SSH
Now, with the SSH proxy set up, connect to the container by specifying the correct port and key.

```
ssh -i AltSchool-keypair-1.pem -p 2222 root@localhost
```
Explanation:

```-i AltSchool-keypair-1.pem``` specifies the SSH private key.
```-p 2222``` uses the host’s port 2222, which forwards to the container’s SSH port.
Ensure the SSH server is installed in the container (sudo apt update && sudo apt install openssh-server).

9. Deleting the Web Server Proxy Configuration
If you no longer need the web server proxy (e.g., myproxy80), delete it to keep things secure and clean.

```
sudo lxc config device remove ubuntu-container myproxy80
```
Explanation:

This removes ```myproxy80``` from the container, freeing up port 8888 on your host.
Tip: Deleting unused proxies is a good practice for security and simplicity.

10. Checking Existing Configurations
To view all configurations and proxy devices on a container, use:
```
sudo lxc config show ubuntu-container
```

Explanation: This command lists all devices, configurations, and proxies active on ubuntu-container, so you can identify and manage settings as needed.

**Summary of Steps**
**Install LXD:** Set up LXD to manage your LXC containers.
**Create a Free Container:** Use lxc launch to start as many containers as you need without extra costs.
**Access the Container with LXC:** Use lxc exec to enter the container.
**Set Up SSH Keys:**
- Use an existing key or generate a new one and copy the public key to the container.
- Add SSH Proxy Binding: Forward SSH from a host port to the container’s SSH port (2222 to 22).
**Add Web Server Proxy Binding:** Forward web traffic from a host port to the container’s HTTP port (8888 to 80).
**Connect via SSH and Access Web Server:** Use SSH with the forwarded port to connect securely and test the web server at http://<host-ip>:8888.
**Delete Unneeded Proxies:** Remove proxy devices when they’re no longer needed to keep your setup secure.
**Check Configurations:** Use lxc config show to review all active configurations.

With these steps, you’re set up to freely create, configure, and access LXC containers for learning without any cloud costs, using only your local machine and the power of LXD’s management tools. Enjoy your free containerized environment for testing, learning, and experimenting!