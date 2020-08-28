#!/bin/bash

DNF_CMD=$(which dnf)

set -e

# Mac OSX
if [[ $(uname -s) = Darwin ]]; then
    # Download and install Command Line Tools
    if [[ ! -x /usr/bin/gcc ]]; then
        echo "Info   | Installing | xcode"
        xcode-select --install
    fi

    # Download and install Homebrew
    if [[ ! -x /usr/local/bin/brew ]]; then
        echo "Info   | Installing | homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Download and install Ansible
    if [[ ! -x /usr/local/bin/ansible ]]; then
        echo "Info   | Installing | ansible"
        brew install ansible
    fi

# Fedora / CentOS / RHEL
elif [[ -x $DNF_CMD ]]; then
    # Download and install Ansible
    echo "Info   | Installing | ansible"
    dnf install -y ansible

# ¯\_(ツ)_/¯
else
    echo "error: can't install ansible"
    exit 1;
fi

ansible-galaxy install -r requirements.yml

echo -e "\nYour system is ready for provisioning!\n"
echo -e "Run 'ansible-playbook main.yml -i inventory -K' to do so\n"
