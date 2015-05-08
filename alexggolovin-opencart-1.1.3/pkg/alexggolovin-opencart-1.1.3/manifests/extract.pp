# Class opencart::extract
#
# Class opencart::extract - exctarcts downloaded compressed file to the temporary folder
#

class opencart::extract 

inherits ::opencart::params {

   package {'unzip':
       ensure  => present,
   }

   exec {"unzip-${zip_destination}":
       command => "unzip $zip_destination -d $unzip_destination",
       path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
       require => Package['unzip'],
       onlyif  => [ "test ! -f ${unzip_destination}/opencart*/license.txt && test ! -f /var/www/${sitename}/php.ini"],
  }

}
