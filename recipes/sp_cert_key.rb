
# Get sp-cert an sp-key contents

begin
  if Chef::Config[:solo]
    begin 
      shibboleth_sp_data_bag = Chef::DataBagItem.load("shibboleth","sp")['local']
      sp_cert = shibboleth_sp_data_bag['cert']
      sp_key = shibboleth_sp_data_bag['key']
    rescue
      Chef::Log.info("No shibboleth-sp data bag found")
    end
  else
    begin 
      shibboleth_sp_data_bag = Chef::EncryptedDataBagItem.load("shibboleth","sp")[node.chef_environment]
      sp_cert = shibboleth_sp_data_bag['cert']
      sp_key = shibboleth_sp_data_bag['key']
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