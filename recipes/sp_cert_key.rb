#
#
# Cookbook Name:: shibboleth-sp
# Recipe:: sp_cert_key
#
# Copyright 2013 Nathan Mische
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


# Get sp-cert an sp-key contents

begin
  if Chef::Config[:solo]
    begin 
      shibboleth_sp_data_bag = Chef::DataBagItem.load("shibboleth","sp")
      cert_key = shibboleth_sp_data_bag[node['shibboleth-sp']['entityID']]
      cert_key ||= shibboleth_sp_data_bag['local']
      sp_cert = cert_key['cert']
      sp_key = cert_key['key']
    rescue
      Chef::Log.info("No shibboleth-sp data bag found")
    end
  else
    begin 
      shibboleth_sp_data_bag = Chef::EncryptedDataBagItem.load("shibboleth","sp")
      cert_key = shibboleth_sp_data_bag[node['shibboleth-sp']['entityID']]
      cert_key ||= shibboleth_sp_data_bag[node.chef_environment]
      sp_cert = cert_key['cert']
      sp_key = cert_key['key']
    rescue
      Chef::Log.info("No shibboleth-sp encrypted data bag found")
    end
  end
ensure    
  sp_cert ||= node['shibboleth-sp']['cert']
  sp_key ||= node['shibboleth-sp']['key']
end

# Generate sp-cert and sp-key

file "#{node['shibboleth-sp']['dir']}/sp-cert.pem" do
    action :create
    owner node['shibboleth-sp']['user']
    group node['shibboleth-sp']['user']
    mode 00644
    content sp_cert
    notifies :restart, "service[shibd]", :delayed
end

file "#{node['shibboleth-sp']['dir']}/sp-key.pem" do
    action :create
    owner node['shibboleth-sp']['user']
    group node['shibboleth-sp']['user']
    mode 00600
    content sp_key
    notifies :restart, "service[shibd]", :delayed
end