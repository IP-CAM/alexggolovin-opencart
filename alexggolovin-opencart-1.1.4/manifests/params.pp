#Class: opencart::params
#
# This class manages OpenCart deploy parameters
#
# ==Parameters: supposed to be changed 
#
#  -The $sitename - apache virtual host folder and new site address name
#  -The $sitepath - site content location on the disk path
#  -The $siteowner - site username owner name who will have access to the site
#  -The $sitegroup - site group name which should has acces to the site
#  -The $content - "http" download link to the opencart ".zip" installation file  
#  -The $zip_destination - local folder and filename for downloaded ".zip" opencart installation file 
#  -The $unzip_destination - temporary folder for opencart installation file extraction
#  -The $mydb - name of the new created opencart's mysql database 
#  -The $myuser - mysql database user owner of new created db (root on localhost by default)
#  -The $mypass - password of the new db user owner (not requried for root on localhost by default)   
#
# ==System packages: not required to be changed
# OS depend distro packages required by OpenCart to be installed
#  -The OS depends packages: $php_gd, $php_mysql, $php_mcrypt, $php_curl  
#

class opencart::params{
	$sitename          = 'opencart.local'
	$sitepath	   = '/var/www/opencart.local'
	$siteowner	   = 'root'
	$sitegroup	   = 'root'
	$content           = 'https://github.com/alexggolovin/opencart/raw/master/opencart-2.0.2.0.zip'
	$zip_destination   = '/tmp/temp.zip'
	$unzip_destination = '/tmp'
	$mydb		   = 'opencart'
	$myuser		   = 'root'
	$mypass		   = ''

  case $operatingsystem {                                                                                                    
    'CentOS',                                                                                                                
    'RedHat': {                                                                                                              
      $php_gd     = 'php-gd'
      $php_mysql  = 'php-mysql'
      $php_mcrypt = 'php-mcrypt'
    }                                                                                                                        
    'Debian',                                                                                                                
    'Ubuntu': {
      $php_gd     = 'php5-gd'
      $php_curl   = 'php5-curl' 
      $php_mysql  = 'php5-mysql'
      $php_mcrypt = 'php5-mcrypt'
    }  
  }
}
