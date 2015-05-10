#Class opencart::deploy
#
#Class opencart::deploy - install opencart to the site folder with required read/write permissions changes 
#and selinux changes in case of RedHat based distributions.
#

class opencart::deploy

inherits ::opencart::params {

   exec {"cp-${sitename}":
       command => ["cp -r ${unzip_destination}/opencart*/upload/* ${sitepath}/ && mv ${sitepath}/config-dist.php ${sitepath}/config.php && mv ${sitepath}/admin/config-dist.php ${sitepath}/admin/config.php && chmod -Rvv 777 ${sitepath}/system/cache/ && chmod -Rvv 777 ${sitepath}/system/logs/ && chmod -Rvv 777 ${sitepath}/system/download && chmod -Rvv 777 ${sitepath}/system/upload && chmod -Rvv 777 ${sitepath}/image/ && chmod -Rvv 777 ${sitepath}/image/cache/ && chmod -Rvv 777 ${sitepath}/image/catalog/ && chmod -Rvv 777 ${sitepath}/config.php && chmod -Rvv 777 ${sitepath}/admin/config.php && echo `date +%F\ %T` > ${sitepath}/admin/opencart_deployed.txt"],
       path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
       onlyif  => "test ! -f ${sitepath}/php.ini",
   }

   case $operatingsystem {
        'RedHat',
        'CentOS': {
           exec {"selinux-${sitename}":
           command => ["setsebool -P httpd_anon_write=1 && chcon -R -t public_content_rw_t ${sitepath}/ && mv ${sitepath}/admin/opencart_deployed.txt ${sitepath}/admin/opencart_deployed_date.txt"],
	   path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
           onlyif => "test -f ${sitepath}/admin/opencart_deployed.txt",
           }
        }
  }
} 
