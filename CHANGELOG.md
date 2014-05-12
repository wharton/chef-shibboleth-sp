## 0.3.0

* Updated default recipe to support yum cookbook version 3.x.

## 0.2.2

* Added `node['shibboleth-sp']['attributePrefix']` attribute. 

## 0.2.1

* Added `node['shibboleth-sp']['Handler']['MetadataGenerator']['childElements']` attribute. 

## 0.2.0

* Added `node['shibboleth-sp']['logging']` attributes and shibd.logger template

## v0.1.6

* Changed sp certificate and key lookup to support storing key pairs per entityID in the sp data bag.

## v0.1.5

* Added attribute to enabale/disable SAML attribute query.

## v0.1.4 

* Added additional attributes for error configuration.

## v0.1.3 

* Minor updates to support centos.

## v0.1.2 

* Added sp_cert_key recipe.

## v0.1.1

* Changed case statement to use platform rather than platform family.

## v0.1.0

* Added platform specific user node attribute.

## v0.0.8

* Updated README
* Added attributes for status handler acl, metadataprovider, and attribute-map.
* Moved apache2 recipe functionality to default

## v0.0.7

* Additional attribute check for attribute-map

## v0.0.6

* Fixed SP key generation creates check to absolute path
* attribute-map does not assume defaults for name-id

## v0.0.5

* Add Ubuntu SP key generation to default recipe

## v0.0.4

* Fixed attribute-map template

## v0.0.3

* Added additional libapache2-mod-shib2 package for Ubuntu shibd installation

## v0.0.2

* Addtional packages for Ubuntu installation

## v0.0.1

* Initial alpha testing
