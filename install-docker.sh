#!/bin/bash

# Update package lists
sudo apt-get update

# Install prerequisite packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker's stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package lists again (after adding new repository)
sudo apt-get update

# Install Docker CE
sudo apt install docker-ce -y

echo "Docker installation script finished."
