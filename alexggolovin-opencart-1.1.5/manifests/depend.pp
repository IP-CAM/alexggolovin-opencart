#Class opencart::depend
#
#Class opencart::depend - installs additional php packages with configuration changes required by opencart
#
#  There are additional packages required to be installed for successul OpenCart deploy: 
# "php5-gd php5-curl php5-mysql php5-mcrypt" with "php5enmod mcrypt" apply action in case of Debian based distributions
#  and next apache service restart.
#

class opencart::depend 

inherits ::opencart {

package {$php_gd: ensure => installed,}
package {$php_mysql: ensure => installed,}
package {$php_mcrypt: ensure => installed,}

case $operatingsystem {
      'Debian',
      'Ubuntu': {
		  package {$php_curl: ensure => installed,}
                  exec {"php5enmod-${php_mcrypt}": 
		  command => "php5enmod mcrypt",
                  path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
                  require => Package["${php_mcrypt}"],
                  onlyif => [ "test ! -f /etc/php5/cli/conf.d/20-mcrypt.ini"],
                  }
    }
  }
}
