#!/bin/bash

# Use a specific path
PATH="/usr/bin:/usr/local/bin:/usr/local/heroku/bin:/opt/aws/bin:$PATH"

# Install Neptuneio agent
NEPTUNEIO_KEY="b7bfe04856cb4388b9c93061a2f43acb" bash -c "$(curl -sS -L https://raw.githubusercontent.com/neptuneio/nagent/prod/src/install_nagent.sh)"

# Give neptuneio agent sudo permissions
# echo "neptuneioagent ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo 'Defaults:neptuneioagent !requiretty' >> /etc/sudoers

# Install Heroku CLI
wget -qO- https://toolbelt.heroku.com/install.sh | sh

# Install AWS CLI
pip install -U awscli

# Install Softlayer CLI
pip install -U softlayer

# Install Digital ocean tugboat CLI
gem install tugboat

# Generic PATH variable update for agent to pick up various CLIs
echo "PATH=$PATH ; export PATH" >> ~neptuneioagent/.bashrc
source ~neptuneioagent/.bashrc

# Restart agent
service nagentd restart
