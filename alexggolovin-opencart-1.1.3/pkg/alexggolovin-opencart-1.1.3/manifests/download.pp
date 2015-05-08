# Class opencart::download
#
# Class opencart::download - downloads opencart installation ".zip" pacakge from the internet
#

class opencart::download 

inherits ::opencart::params {

   package {'wget':
       ensure => present,
   }

   exec {"wget-${content}":
       command => "wget ${content} -O ${zip_destination}",
       path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ], 
       require => Package['wget'],
       onlyif => [ "test ! -f ${zip_destination} && test ! -f /var/www/${sitename}/php.ini"],
   }
}
