# alexggolovin-opencart release 1.1.2

#### Table of Contents

1. [Overview](#overview)
2. [Module Structure Description](#module-structure-description)
3. [OpenCart Setup](#setup)
    * [What opencart affects](#what-opencart-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with opencart](#beginning-with-opencart)
4. [Classes Advanced Usage](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Release Notes](#releasenotes)


## Overview
 This module created for deploy amazing OpenCart opensource ecommerce CMS on the new installed Linux server.
 All required additional componenets: RedHat/CentOS RPM EPEL repository,  web server, database server, php, will be installed and configured by this module automatically to get CMS working in seconds! (40.48 seconds on RHEL server with 1CPU and 1Gb of RAM). Operating systems supported: RedHat/CentOS/Debian/Ubuntu.


## Module Structure Description
 Be aware, this module installs required dependencies to the puppet master server: alexggolovin-lamp, puppetlabs-apache with puppetlabs-stdlib and puppetlabs-concat, puppetlabs-mysql with nanliu-staging, EPEL repo for RedHat based distros which required for php-mcrypt package and installed with help of epel-release rpm native package. This modules were chosen as the core modules for lamp stack deploy because of their complex functionality and multiple configurations capacities. 
 I trust to all modules created by "puppetlabs" team. And believe it's better to use the best modules created by professionals which is already exists and well tested, instead of spend a lot of time on creating the worse one. 


## OpenCart Setup
### What opencart affects
* configuration files and directories (created and written to)
    * **WARNING**: Configurations that are *not* managed by Puppet will be purged.
* package/service/configuration files for Apache
* Apache modules
* virtual hosts
* listened-to ports
* MySQL server and database creation 
* PHP installations and configurations
* All posible OpenCart CMS deploy configurations


### Setup Requirements
Debian,Ubuntu,RHEL or CentOS Linux operating system with puppet agent installed and configured on it, all other required components will be installed automatically. 


### Beginning with opencart
1. All required params.pp parameters must be preconfigured before this module usage beginning. 

BY DEFAULT: opencart.local virtualhost on port "80" and site foloder with mysql "opencart" database (next usage with root user from localhost and empty password) will be created.
  -The $sitename - apache virtual host folder and new site address name
  -The $content - "http" download link to the opencart ".zip" installation file  
  -The $zip_destination - local folder and filename for downloaded ".zip" opencart installation file 
  -The $unzip_destination - temporary folder for opencart installation file extraction
  -The $mydb - name of the new created opencart's mysql database 
  -The $myuser - mysql database user owner of new created db (root on localhost by default)
  -The $mypass - password of the new db user owner (not requried for root on localhost by default)   

2. To get OpenCart installed on your "mywebserver.dev.local" node, the opencart class needs to be added in site.pp configuration file:

```puppet
    node 'mywebserver.dev.local' {
       include opencart
    }
```

## Classes Advanced Usage

The next module classes responsible for:

1. Class init - main class responsible for params and classes assignment with deploy sequence; 

2. Class params - controls all main configuration changes, like site and db name or installation zip file download source; 

3. Class opencart::servers - deploys LAMP stack, "::apache::vhost" section is responsible for all configurations of the new created sites include virtualhost parameters where just port, site foloder and name has been added by default, "mysql_database" controls opencart's database creation process. There are more options could be added when required, for example:

```puppet
    apache::vhost { 'opencartssl.local':
      port            => 443,
      ssl             => true,
      docroot         => $docroot,
      scriptalias     => $scriptalias,
      serveradmin     => $serveradmin,
      access_log_file => "ssl_${access_log_file}",
      }

  mysql::db { 'mydb':
      user     => 'myuser',
      password => 'mypass',
      host     => 'localhost',
      grant    => ['SELECT', 'UPDATE'],
     }
```

 More examples could be found in the parent puppetlabs-apache and mysql modules "/etc/puppet/modules/apache/README.md","/etc/puppet/modules/mysql/README.md" descriptions, which were used as a dependency parts of the "alexggolovin-opencart" module for apache and mysql servers deploy. This both modules configurations also could be changed directly in their own folders, to get opencart deployed with optional required configurations.

 4. Class opencart::depend - installs additional php packages with configuration changes required by opencart
There are additional packages required to be installed for successul OpenCart deploy: "php5-gd php5-curl php5-mysql php5-mcrypt" with "php5enmod mcrypt" apply action in case of Debian based distributions, and next apache service restart.  

 5. Class opencart::download - downloads opencart installation ".zip" pacakge from the internet

 6. Class opencart::extract - exctarcts downloaded compressed file to the temporary folder
 
 7. Class opencart::deploy - install opencart to the site folder with required read/write permissions changes and selinux changes in case of RedHat based distributions.


## Reference
Look into the parent opencart's modules for review more available deploy configuration options:
/etc/puppet/modules/lamp/README.md
/etc/puppet/modules/apache/README.md
/etc/puppet/modules/mysql/README.md
  

## Limitations
Module tested and supposed to be used with RedHat/CentOS/Debian/Ubuntu operating systems;


## Development
This module could be used by others puppet users as helpful "fast deploy" base for testing OpenCart itself or for creating deploy modules for other CMS systems like Drupal, Joomla or Wordpress, or whatever.


## Release Notes
Release 1.1.2.
OpenCart deploy for RedHat/CentOS/Debian/Ubuntu operating systems.
