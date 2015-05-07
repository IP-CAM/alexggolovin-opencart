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
      docroot => "/var/www/${sitename}",
    }

mysql_database {$mydb:
      ensure  => 'present',
    }

include ::lamp

}
