#
# Cookbook Name:: jenkins 
# Recipe:: default 
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

  package "java-1.6.0-openjdk" do
    action :install
  end

  include_recipe "yum"

  yum_key "jenkins-ci.org.key" do
    url "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
    action :add
  end

  yum_repository "jenkins" do
    description "jenkins"
    url "http://pkg.jenkins-ci.org/redhat"
    enabled 1 
  end

  package "jenkins" do
    action :install
  end

  service "jenkins" do
    action :restart
  end

end

# vim: filetype=ruby.chef
