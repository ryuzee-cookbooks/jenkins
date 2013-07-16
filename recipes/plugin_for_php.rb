#
# Cookbook Name:: jenkins 
# Recipe:: plugin_for_php 
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
when "centos"

  include_recipe "jenkins"

  ## Jenkinsの起動直後に取得に失敗する場合があるが自動リトライされるので非力な環境以外は問題ない
  remote_file "/var/lib/jenkins/jenkins-cli.jar" do
    source "http://localhost:8080/jnlpJars/jenkins-cli.jar"
  end

  cmd = <<"EOS"
  sudo wget -O default.js http://updates.jenkins-ci.org/update-center.json && sed '1d;$d' default.js > default.json && curl -X POST -H "Accept: application/json" -d @default.json http://localhost:8080/updateCenter/byId/default/postBack
EOS
  e = execute cmd do
    action :run
  end

  %w{checkstyle cloverphp dry htmlpublisher jdepend plot pmd violations xunit phing Locale}.each do |plugin_name|
    e = execute "sudo /usr/bin/java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 install-plugin ".concat(plugin_name) do
      action :run
    end
  end

  service "jenkins" do
    action :restart
  end
end

# vim: filetype=ruby.chef
