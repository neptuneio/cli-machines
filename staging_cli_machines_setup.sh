#!/bin/bash

# Use a specific path
PATH="/usr/bin:/usr/local/bin:/usr/local/heroku/bin:/opt/aws/bin:$PATH"

# Install Neptune agent
AGENT_USER="neptune" END_POINT="neptune-staging-env.herokuapp.com" API_KEY="fdf59b33c66c4f3a8f1eff809249b972" bash -c "$(curl -sS -L https://raw.githubusercontent.com/neptuneio/neptune-agent/master/scripts/linux/install_neptune_agent_linux.sh)"

# Give neptune agent sudo permissions
# echo "neptune ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo 'Defaults:neptune !requiretty' >> /etc/sudoers

# Install Heroku CLI
wget -qO- https://toolbelt.heroku.com/install.sh | sh

# Install AWS CLI
pip install -U awscli

# Install Softlayer CLI
pip install -U softlayer

# Install Digital ocean tugboat CLI
gem install tugboat

# Generic PATH variable update for agent to pick up various CLIs
echo "PATH=$PATH ; export PATH" >> ~neptune/.bashrc
source ~neptune/.bashrc

# Restart agent
service neptune-agentd restart
