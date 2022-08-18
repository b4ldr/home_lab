#!/bin/sh
apt-get update
apt-get install vim puppet git ruby-bundler
git clone https://github.com/b4ldr/home_lab /etc/puppet/code/production
chown -R puppet /etc/puppet/code/production
cd /etc/puppet/code/production || exit 1
sudo -u puppet bundle install --path="${BUNDLE_PATH:-.bundle/vendor}"
bundle exec r10k puppetfile install
cp /etc/puppet/code/modules/puppet_apply/files/hiera.yaml /etc/puppet/hiera.yaml
puppet apply  --modulepath=/etc/puppet/code/modules:/usr/share/puppet/modules:/etc/puppet/code/production/modules /etc/puppet/code/production/manifests
