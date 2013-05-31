# chef-shibboleth-sp [![Build Status](https://secure.travis-ci.org/wharton/chef-shibboleth-sp.png?branch=master)](http://travis-ci.org/wharton/chef-shibboleth-sp)

## Description

Installs/Configures Shibboleth Service Provider.

## Requirements

### Platforms

* CentOS 6
* RedHat 6
* Ubuntu 12.04 (Precise)
* Windows 2008 R2 64-bit

### Cookbooks

* apache2
* windows
* yum

## Attributes

* `node['shibboeth-sp']['version']` - Version of shibboleth-sp to
  install (if Windows or from source).
* `node['shibboeth-sp']['user']` - Shibboleth-sp user.

### Simple Attribute-Driven Configuration Attributes

* `node['shibboleth-sp']['Errors']['supportContact']` - admin email, defaults
  to "root@FQDN"
* `node['shibboleth-sp']['Errors']['helpLocation']` - help url, defaults
  to "/about.html"
* `node['shibboleth-sp']['Errors']['styleSheet']` - stylesheet url, defaults
  to "/shibboleth-sp/main.css"
* `node['shibboleth-sp']['Errors']['logoLocation']` - logo url, defaults
  to "/shibboleth-sp/logo.jpg"
* `node['shibboleth-sp']['entityID']` - SP entity URL, defaults to 
  https://FQDN/shibboleth
* `node['shibboleth-sp']['REMOTE_USER']` - REMOTE_USER data returned to web
  server, defaults to "eppn persistent-id targeted-id"
* `node['shibboleth-sp']['sign-messages']` - "true", "false", "front", or
  "back", whether to sign outgoing messages, defaults to "false"
* `node['shibboleth-sp']['Sessions']['checkAddress']` - check source address,
  breaks with NAT/proxy, defaults to "false"
* `node['shibboleth-sp']['Sessions']['cookieProps']` - cookie properties,
  defaults to "; path=/; HttpOnly"
* `node['shibboleth-sp']['Sessions']['handlerSSL']` - only SSL requests will be
  handled, defaults to "false"
* `node['shibboleth-sp']['Sessions']['lifetime']` - defaults to 28800
* `node['shibboleth-sp']['Sessions']['relayState']` - defaults to "ss:mem"
* `node['shibboleth-sp']['Sessions']['timeout']` - defaults to 3600
* `node['shibboleth-sp']['saml-query']` - defaults to `true`
* `node['shibboleth-sp']['SSO']['entityID']` - single IdP entity URL,
  _must_ be set to your IdP unless using `node['shibboleth-sp']['SSO']['discoveryURL']`
* `node['shibboleth-sp']['SSO']['discoveryProtocol']` - Multiple IdP Discovery
  Service Protocol, defaults to "SAMLDS", another protocol is "WAYF"
* `node['shibboleth-sp']['SSO']['discoveryURL']` - Multiple IdP Discovery
  Service URL, will override `node['shibboleth-sp']['SSO']['entityID']`
* `node['shibboleth-sp']['Hanlder']['Status']['acl']` - IPs that can access the
  status handler. Defaults to `127.0.0.1 ::1`. If set to a blank string no acl
  is applied.
* `node['shibboleth-sp']['Handler']['MetadataGenerator']
['childElements']` - Child elements to add to the generated metadata.
* `node['shibboleth-sp']['attribute-map']['name-id']` - A hash with the NameID
  name and id to map from the IdP.
* `node['shibboleth-sp']['MetadataProvider']['path']` - Path to IdP metadata file.
* `node['shibboleth-sp']['MetadataProvider']['url']` - URL of IdP metadata file.
* `node['shibboleth-sp']['MetadataProvider']['backingFilePath']` - Path to cach a
  copy of the IdP metadata if using a URL.
* `node['shibboleth-sp']['MetadataProvider']['reloadInterval']` - Interval to
  check for metadata updates. 
* `node['shibboleth-sp']['attribute-map']['attributes']` - An array of hashs 
  with the name (required), id (required), and nameFormat (optional) of 
  attirbutes to map from the IdP.

### Logging Attributes

For shibd.logger (all default to INFO):
* `node['shibboleth-sp']['logging']['root']` - root log level
* `node['shibboleth-sp']['logging']['OpenSAML']['MessageDecoder']`
* `node['shibboleth-sp']['logging']['OpenSAML']['MessageEncoder']`
* `node['shibboleth-sp']['logging']['OpenSAML']['SecurityPolicyRule']`
* `node['shibboleth-sp']['logging']['Shibboleth']['Listener']`
* `node['shibboleth-sp']['logging']['Shibboleth']['RequestMapper']`
* `node['shibboleth-sp']['logging']['Shibboleth']['SessionCache']`
* `node['shibboleth-sp']['logging']['XMLTooling']['libcurl']`
* `node['shibboleth-sp']['logging']['XMLTooling']['Signature']`
* `node['shibboleth-sp']['logging']['XMLTooling']['SOAPClient']`
* `node['shibboleth-sp']['logging']['XMLTooling']['StorageService']`

### Web Server Specific Attributes

### Platform Specific Attributes

* `node['shibboeth-sp']['redhat']['use_rhn']` - Use RHN-synchronized repository
  for shibboleth installation
* `node['shibboeth-sp']['windows']['url']` - URL for Windows shibboleth-sp.
* `node['shibboeth-sp']['windows']['checksum']` - Checksum for Windows
  shibboleth-sp.

## Recipes

* `recipe[shibboleth-sp]` Installs and enables base Shibboleth Service
  Provider.
* `recipe[shibboleth-sp::apache2]` Base recipe and Apache handling.
* `recipe[shibboleth-sp::iis]` Base recipe and IIS handling.
* `recipe[shibboleth-sp::simple]` Base recipe and simple attribute-driven configuration.
* `recipe[shibboleth-sp::sp_cert_key]` Recipe to configure sp cert and key using data bags or node attributes.

## Usage

For just installation and enabling the Shibboleth Service Provider, just add
`recipe[shibboleth-sp]` to your run list. The other recipes are modular for
specific configuration scenarios.

### Simple Attribute-Driven Configuration

Using `recipe[shibboleth-sp::simple]` gives you a basic attribute-driven model
for configuring simple Shibboleth SPs. Anything beyond the givem attributes,
you are probably better off writing a custom site cookbook, outlined below.

### Custom Shibboleth SP Configuration

Use `recipe[shibboleth-sp]` and create a site cookbook that uses cookbook_files
or templates to overwrite files in the Shibboleth SP directory.

### SP Certificate and Key

The certificate and key used by your SP for signing and encryption will be generated when the SP software is installed. You can choose to use your own certificate for this purpose by using the `shibboleth-sp::sp_cert_key` recipe. This recipe will check for a data bag item `shibboleth.sp` with a key matching the `node['shiboboleth-sp']['entityID']`. If that does not exits it will check for a key matching the chef environment (or `local` for chef-solo). Finally if the data bag does not exist or there are no matching keys the recipe will look to the `node['shibboleth-sp']['cert']` and `node['shibboleth-sp']['key']` attributes.

### Apache Handling

More soon about `recipe[shibboleth-sp::apache2]`.

### IIS Handling

More soon about `recipe[shibboleth-sp::iis]`.
