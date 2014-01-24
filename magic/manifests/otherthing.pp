class magic::otherthing {

  class { 'mysql::server':
    root_password => 'rootpassword',
  }

  mysql_database { 'magic':
    ensure  => 'present',
  }

  package { 'fids-demoapp':
    ensure  => present,
    require => Mysql_database['magic'],
  }

  $connectednodes = query_nodes('Class[magic::webservers]')

  $connectednodes.each |$node| {

    mysql_user { "magic@${node}":
      ensure        => 'present',
      password_hash => mysql_password('kdsjfbdjskbfkjbsdkjfbsdkjbfkjsdbfkbsdkjfbsdbfskjsbdkjbfdsjkbfksjd'),
    }

    mysql_grant { "magic@${node}/magic.*":
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => '*.*',
      user       => "magic@${node}",
      tag        => "mconotify--node--${node}",
    }

  }

}
