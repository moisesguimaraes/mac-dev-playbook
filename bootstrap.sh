#!/bin/bash

set -e

# Ensure Ansible is installed
if [[ ! -x $(which ansible) ]]; then

    # Mac OSX
    if [[ $(uname -s) = Darwin ]]; then

        # Download and install Command Line Tools
        if [[ ! -x $(which gcc) ]]; then
            echo "[INFO] Installing xcode"
            xcode-select --install
        fi

        # Download and install Homebrew
        if [[ ! -x $(which brew) ]]; then
            echo "[INFO] Installing homebrew"
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        # Download and install Ansible
        echo "[INFO] Installing ansible"
        brew install ansible

    # Fedora / CentOS / RHEL
    elif [[ -x $(which dnf) ]]; then

        # Download and install Ansible
        echo "[INFO] Installing ansible"
        sudo dnf install -y ansible

    # ¯\_(ツ)_/¯
    else
        echo "[ERROR] can't install ansible"
        exit 1;
    fi
fi

ansible-galaxy install -r requirements.yml

echo -e "\nYour system is ready for provisioning!\n"
echo -e "Run 'ansible-playbook main.yml -i inventory -K' to do so\n"
