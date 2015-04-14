#Class opencart::deploy
#
#Class opencart::deploy - install opencart to the site folder with required read/write permissions changes 
#and selinux changes in case of RedHat based distributions.
#

class opencart::deploy

inherits ::opencart::params {

   exec {"cp-${sitename}":
       command => ["cp -r ${unzip_destination}/opencart*/upload/* /var/www/${sitename}/ && mv /var/www/${sitename}/config-dist.php /var/www/${sitename}/config.php && mv /var/www/${sitename}/admin/config-dist.php /var/www/${sitename}/admin/config.php && chmod -Rvv 777 /var/www/${sitename}/system/cache/ && chmod -Rvv 777 /var/www/${sitename}/system/logs/ && chmod -Rvv 777 /var/www/${sitename}/system/download && chmod -Rvv 777 /var/www/${sitename}/system/upload && chmod -Rvv 777 /var/www/${sitename}/image/ && chmod -Rvv 777 /var/www/${sitename}/image/cache/ && chmod -Rvv 777 /var/www/${sitename}/image/catalog/ && chmod -Rvv 777 /var/www/${sitename}/config.php && chmod -Rvv 777 /var/www/${sitename}/admin/config.php && echo `date +%F\ %T` > /var/www/${sitename}/admin/opencart_deployed.txt"],
       path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
       onlyif  => "test ! -f /var/www/${sitename}/php.ini",
   }

   case $operatingsystem {
        'RedHat',
        'CentOS': {
           exec {"selinux-${sitename}":
           command => ["setsebool -P httpd_anon_write=1 && chcon -R -t public_content_rw_t /var/www/${sitename}/ && mv /var/www/${sitename}/admin/opencart_deployed.txt /var/www/${sitename}/admin/opencart_deployed_date.txt"],
	   path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
           onlyif => "test -f /var/www/${sitename}/admin/opencart_deployed.txt",
           }
        }
  }
} 
