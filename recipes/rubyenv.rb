#
# Cookbook Name:: jenkins 
# Recipe:: plugin
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2012, Ryutaro YOSHIBA 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in wrhiting, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node[:platform]
when "centos", "amazon"

  template "/etc/sudoers.d/jenkins" do
    source "sudoers.erb"
    owner "root"
    group "root"
    mode "0440"
    notifies :restart, "service[jenkins]"
  end

  cmd = <<"EOS"
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
EOS

  e = execute cmd do
    action :run
  end

  cmd = <<"EOS"
sudo -H -u jenkins -s bash -c 'curl -L https://get.rvm.io | bash'
sudo -H -u jenkins -s bash -c 'source /var/lib/jenkins/.rvm/scripts/rvm; rvm install 1.9.3'
sudo -H -u jenkins -s bash -c 'source /var/lib/jenkins/.rvm/scripts/rvm; rvm use 1.9.3 --default' 
EOS

  e = execute cmd do
    action :run
  end

end

# vim: filetype=ruby.chef
