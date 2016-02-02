#!/bin/bash

CLI_AGENT_USER="neptune"

# Create the new user if it does not exist
id -u $CLI_AGENT_USER &>/dev/null || useradd $CLI_AGENT_USER -m

# Use a specific path
export PATH="/usr/bin:/usr/local/bin:/usr/local/heroku/bin:/opt/aws/bin:$PATH"

# Install git
yum install -y git

# Install postgresql for heroku pg-extras plugin
yum install -y postgresql94

# Install Heroku CLI
wget -qO- https://toolbelt.heroku.com/install.sh | sh

# Install heroku pg-extras plugin as agent user
sleep 2
su - $CLI_AGENT_USER -s /bin/bash -c "/usr/local/heroku/bin/heroku update"
su - $CLI_AGENT_USER -s /bin/bash -c "/usr/local/heroku/bin/heroku plugins:install git://github.com/heroku/heroku-pg-extras.git"

# Upgrade pip to avoid warnings/errors
# pip install -U pip

# Install AWS CLI
pip install -U awscli

# Install Softlayer CLI
pip install -U softlayer

# Install Digital ocean tugboat CLI
gem install tugboat

# Generic PATH variable update for agent to pick up various CLIs
CLI_AGENT_USER_BASHRC=`eval echo ~$CLI_AGENT_USER/.bashrc`
echo "PATH=$PATH ; export PATH" >> $CLI_AGENT_USER_BASHRC
source $CLI_AGENT_USER_BASHRC

# Install Neptune agent
AGENT_USER=$CLI_AGENT_USER API_KEY="b7bfe04856cb4388b9c93061a2f43acb" bash -c "$(curl -sS -L https://raw.githubusercontent.com/neptuneio/neptune-agent/prod/scripts/linux/install_neptune_agent_linux.sh)"

# Give neptune agent sudo permissions
# echo "neptune ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo 'Defaults:neptune !requiretty' >> /etc/sudoers

# Restrict commands
#cd /bin
#chmod 700 *
#chmod 4111 su
#chmod 755 date echo awk basename bash cut date echo egrep env false fgrep gawk grep mktemp more sed sh sleep sort true

#cd /usr/bin
#chmod 700 *
#chmod 4111 sudo
#chmod 755 awk aws aws_completer cut curl env gawk git* id less openssl python* ruby* sha* ssh* tail tty tee wc psql*

# Restart agent
service neptune-agentd restart

