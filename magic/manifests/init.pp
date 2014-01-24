# == Class: magic
#
# Full description of class magic here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { magic:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class magic ( $config ){

  $balancers  = query_nodes('Class[magic::balancers]')
  $webservers = query_nodes('Class[magic::webservers]')
  $otherthing = query_nodes('Class[magic::otherthing]')

  $balancercount = size($balancers)
  $webserverscount = size($webservers)
  $otherthingcount = size($otherthing)

  service { 'iptables':
    ensure => false,
    enable => false,
  }

  if $balancercount < $config['balancers'] or $clientcert in $balancers {
    include magic::balancers
    $done = true
  }

  if ( $webserverscount < $config['webservers'] or $clientcert in $webservers) and ! $done {
    include magic::webservers
    $done = true
  }

  if ( $otherthingcount < $config['otherthing'] or $clientcert in $otherthing) and ! $done {
    include magic::otherthing
    $done = true
  }

}
