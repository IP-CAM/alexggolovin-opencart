# == Class: opencart
# Main class which used for deploy OpenCart opensource based ecommerce CMS  
#
# === Parameters: must be changed inside "opencart::params" (params.pp file) class 
#  -The $sitename - apache virtual host folder and new site address name
#  -The $content - "http" download link to the opencart ".zip" installation file  
#  -The $zip_destination - local folder and filename for downloaded ".zip" opencart installation file 
#  -The $unzip_destination - temporary folder for opencart installation file extraction
#  -The $mydb - name of the new created opencart's mysql database 
#  -The $myuser - mysql database user owner of new created db (root on localhost by default)
#  -The $mypass - password of the new db user owner (not requried for root on localhost by default)   
#
# === Used Classes: the next added classes responsible for:
# include opencart::servers - deploys LAMP stack with preconfigured options
# include opencart::depend - installs additional PHP packages with configuration changes required by opencart
# include opencart::download - downloads opencart installation ".zip" pacakge from the internet
# include opencart::extract - extarcts downloaded compressed file to the temporary local folder
# include opencart::deploy - installs opencart to the site folder with required read/write permissions changes
#
# === Authors
# Alexander Golovin https://github.com/alexggolovin 
#
# === Copyright
# Copyright 2015 Alexander Golovin, https://github.com/alexggolovin
#

class opencart (

$sitename	      = $::opencart::params::sitename,
$content	      = $::opencart::params::content,
$zip_destination      = $::opencart::params::zip_destination,
$unzip_destination    = $::opencart::params::unzip_destination,
$mydb		      = $::opencart::params::mydb,
$myuser		      = $::opencart::params::myuser,
$mypass		      = $::opencart::params::mypass,

) inherits ::opencart::params {

include opencart::servers
include opencart::depend
include opencart::download
include opencart::extract
include opencart::deploy

Class ['opencart::servers'] -> Class['opencart::depend'] -> Class['opencart::download'] -> Class['opencart::extract'] -> Class['opencart::deploy']

}
