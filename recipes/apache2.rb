#
# Cookbook Name:: shibboleth-sp
# Recipe:: apache2
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
include_recipe 'shibboleth-sp'
include_recipe 'apache2'

Chef::Log.fatal("#{node['kernel']['machine']}")
if node['kernel']['machine'] == 'x86_64'
	shib_lib_path = '/usr/lib64/shibboleth'
elsif node['kernel']['machine'] == 'i686'
	shib_lib_path = '/usr/lib/shibboleth'
else
	Chef::Log.fatal('What is the machine')
end
	
apache_module 'shib' do
	conf true
	module_path "#{shib_lib_path}/mod_shib_22.so"
	identifier "mod_shib"
end

service "http" do
	action :restart
end
