#Class opencart::servers
#
# Class opencart::servers - deploys LAMP stack.
#
# "::apache::vhost" - section is responsible for all configurations of the new created sites:
# include virtualhost parameters where just port, site foloder and name has been added by default, 
#
# "mysql_database" - controls opencart's database creation process.
#

class opencart::servers

inherits ::opencart::params {

::apache::vhost { "$sitename":
      port    => '80',
      docroot => "${sitepath}",
      docroot_owner => "${siteowner}",
      docroot_group => "${sitegroup}",
    }

mysql_database {$mydb:
      ensure  => 'present',
    }

include ::lamp

}
