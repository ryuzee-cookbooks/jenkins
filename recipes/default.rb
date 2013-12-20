#
# Cookbook Name:: jenkins 
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2012, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

case node[:platform]
when "centos", "amazon"

  package "java-1.6.0-openjdk" do
    action :install
  end

  include_recipe "yum-epel"

  yum_repository "jenkins" do
    description "jenkins"
    url "http://pkg.jenkins-ci.org/redhat"
    gpgkey "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
    action :create
  end

  package "jenkins" do
    action :install
  end

  service "jenkins" do
    action [:enable , :start]
  end

when "ubuntu"

#  package "apt" do
#    action :upgrade
#  end

  include_recipe "apt"

  apt_repository "jenkins" do
    uri "http://pkg.jenkins-ci.org/debian"
    key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
    components ["binary/"]
    action :add
    notifies :run, "execute[apt-get update]", :immediately
  end

  package "jenkins" do
    action :install
  end

  service "jenkins" do
    action [:enable, :start]
  end

end

# vim: filetype=ruby.chef
