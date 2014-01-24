class magic::webservers (
  $dbpassword = hiera('dbpassword','foooo'),
){

   tag 'mconotify--class--magic__balancers'
#   tag 'mconotify--node--centos64a'
#   notify { 'magical webserver land': }

   include apache
   package { 'fids-demoapp':
     ensure  => present,
     require => Class['apache'],
   }
   
#  $ret = pdbresourcequery( ['and', ['=','type','Mysql_grant'], ['=',['parameter','user'],"magic@${hostname}"]]) 
#  if $ret {
#    $dbhost = $ret[0]['certname']
#    file { '/etc/secretdatabaseconnectionstring':
#      ensure  => file,
#      content => inline_template("user = magic\npassword = <%= @dbpassword %>\ndbhost = <%= @dbhost %>\n"),
#      owner   => 'root',
#      group   => 'root',
#      mode    => '0600',
#    }
#  }
}
