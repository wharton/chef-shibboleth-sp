#
# Cookbook Name:: shibboleth-sp
# Attributes:: shibboleth-sp
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

default['shibboleth-sp']['Errors']['supportContact'] = "root@#{node['fqdn']}"
default['shibboleth-sp']['entityID'] = "https://#{node['fqdn']}/shibboleth"
default['shibboleth-sp']['REMOTE_USER'] = "eppn persistent-id targeted-id"
default['shibboleth-sp']['Sessions']['checkAddress'] = "false"
default['shibboleth-sp']['Sessions']['cookieProps'] = "http"
default['shibboleth-sp']['Sessions']['handlerSSL'] = "false"
default['shibboleth-sp']['Sessions']['lifetime'] = 28800
default['shibboleth-sp']['Sessions']['relayState'] = "ss:mem"
default['shibboleth-sp']['Sessions']['timeout'] = 3600

# Single IdP (overrode by ['SSO']['discoveryURL'])
default['shibboleth-sp']['SSO']['entityID'] = "https://idp.example.org/idp/shibboleth"
default['shibboleth-sp']['SSO']['discoveryProtocol'] = "SAMLDS"

# Multiple IdP Discovery (overrides ['SSO']['entityID'])
default['shibboleth-sp']['SSO']['discoveryURL'] = ""
default['shibboleth-sp']['version'] = "2.5.0"

# Metadata Provider
# default['shibboleth-sp']['MetadataProvider']['path'] = ""
# default['shibboleth-sp']['MetadataProvider']['url'] = ""
# default['shibboleth-sp']['MetadataProvider']['backingFilePath'] = ""
# default['shibboleth-sp']['MetadataProvider']['reloadInterval'] = ""

# Platform specific customizations
case node['platform']
when 'windows'
  default['shibboleth-sp']['dir'] = "C:/opt/shibboleth-sp/etc/shibboleth"
  default['shibboleth-sp']['windows']['url']      = "http://shibboleth.net/downloads/service-provider/latest/win64/shibboleth-sp-#{node['shibboleth-sp']['version']}-win64.msi"
  default['shibboleth-sp']['windows']['checksum'] = "d40431e3b4f2aff8ae035f2a434418106900ea6d9a7d06b2b0c2e9a30119b54c"
else
  default['shibboleth-sp']['dir'] = "/etc/shibboleth"
  default['shibboleth-sp']['redhat']['use_rhn'] = false
end

# SAML attributes for attribute-map.xml

# default['shibboleth-sp']['attribute-map']['name-id'] = { "name" => "emailAddress", "id" => "emailAddress" }
# default['shibboleth-sp']['attribute-map']['attributes'] = [
	# {"name" => "firstName", "id" => "firstName" },
	# {"name" => "lastName", "id" => "lastName", "nameFormat" => "basic"}
# ]

