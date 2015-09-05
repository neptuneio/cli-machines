#!/bin/bash

# Use a specific path
PATH="/usr/bin:/usr/local/bin:/usr/local/heroku/bin:/opt/aws/bin:$PATH"

NAGENT_USER="neptuneioagent"

# Install Neptuneio agent
NEPTUNE_ENDPOINT="neptune-staging-env.herokuapp.com" NEPTUNEIO_KEY="fdf59b33c66c4f3a8f1eff809249b972" bash -c "$(curl -sS -L https://raw.githubusercontent.com/neptuneio/nagent/staging/src/install_nagent.sh)"

# Give neptuneio agent sudo permissions
# echo "neptuneioagent ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo 'Defaults:neptuneioagent !requiretty' >> /etc/sudoers

# Install Heroku CLI
su - $NAGENT_USER -s /bin/bash -c "wget -qO- https://toolbelt.heroku.com/install.sh | sh"

# Install AWS CLI
su - $NAGENT_USER -s /bin/bash -c "pip install -U awscli"

# Generic PATH variable update for agent to pick up various CLIs
echo "PATH=$PATH ; export PATH" >> ~neptuneioagent/.bashrc
source ~neptuneioagent/.bashrc

# Restart agent
service nagentd restart
