#
# Cookbook Name:: jenkins::http
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

include_recipe "apache2-simple"

case node[:platform]
when "ubuntu", "debian"

  cmd = "a2enmod proxy && a2enmod proxy_http"
  execute cmd do
    action :run
    only_if do
      ! File.exists?("/etc/apache2/conf-enabled/jenkins.conf") 
    end
  end

  template "/etc/apache2/conf-enabled/jenkins.conf" do
    source "jenkins.conf.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[apache2]'
  end
when "centos", "amazon"
  template "/etc/httpd/conf.d/jenkins.conf" do
    source "jenkins.conf.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[httpd]'
  end
end
