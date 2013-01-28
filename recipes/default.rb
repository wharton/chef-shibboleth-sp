#
# Cookbook Name:: shibboleth-sp
# Recipe:: default
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

repo_url = "http://download.opensuse.org/repositories/security:/shibboleth"

case node['platform']
when 'centos'
  include_recipe "yum"
  case node['platform_version'].to_i
  when 5
    repo_location = "CentOS_5"
  when 6
    repo_location = "CentOS_CentOS-6"
  end

  yum_key "RPM-GPG-KEY-security:shibboleth" do
    url "#{repo_url}/#{repo_location}/repodata/repomd.xml.key"
    action :add
  end

  yum_repository "security:shibboleth" do
    description "Shibboleth Repository"
    url "#{repo_url}/#{repo_location}/"
    key "RPM-GPG-KEY-security:shibboleth"
    type "rpm-md"
    action :add
  end

  package "shibboleth"
when 'redhat'
  unless node['shibboleth-sp']['redhat']['use_rhn']
    include_recipe "yum"
    repo_location = "RHEL_#{node['platform_version'].to_i}"

    yum_key "RPM-GPG-KEY-security:shibboleth" do
      url "#{repo_url}/#{repo_location}/repodata/repomd.xml.key"
      action :add
    end

    yum_repository "security:shibboleth" do
      description "Shibboleth Repository"
      url "#{repo_url}/#{repo_location}/"
      key "RPM-GPG-KEY-security:shibboleth"
      type "rpm-md"
      action :add
    end
  end

  package "shibboleth"
when 'ubuntu'
  include_recipe "apache2"

  %w{ libapache2-mod-shib2 libshibsp-dev libshibsp-doc opensaml2-tools shibboleth-sp2-schemas }.each do |pkg|
    package pkg
  end

  apache_module "shib2"

  execute "Generate Shibboleth SP Key" do
    cwd node['shibboleth-sp']['dir']
    command "shib-keygen"
    creates "#{node['shibboleth-sp']['dir']}/sp-key.pem"
  end
when 'windows'
  windows_package "Shibboleth Service Provider" do
    source node['shibboleth-sp']['windows']['url']
    checksum node['shibboleth-sp']['windows']['checksum']
    action :install
    not_if { File.exists? "C:/opt/shibboleth/sbin/shibd.exe" }
  end
end 

service "shibd" do
  service_name "Shibboleth 2 Daemon (Default)" if platform? 'windows'
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
