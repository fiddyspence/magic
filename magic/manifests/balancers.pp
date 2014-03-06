class magic::balancers {

  class { 'haproxy': }
  haproxy::listen { 'magicwithunicornsandrainbows':
    ipaddress => $::ipaddress_eth1,
    ports     => '80',
    options   => ['tcplog'],
  }

  haproxy::listen { 'stats':
    ipaddress => $::ipaddress,
    ports     => '9090',
    options   => {
      'mode'  => 'http',
      'stats' => ['uri /', 'auth puppet:puppet']
      },
    }

  $balancers  = query_nodes('Class[magic::webservers]')

  $balancers.each |$balancer| {

    $node = query_facts("clientcert=${balancer}",['ipaddress_eth1'])
    notify { $node: }
    haproxy::balancermember { $balancer:
      listening_service => 'magicwithunicornsandrainbows',
      server_names      => $balancer,
      ipaddresses       => $node[$balancer]['ipaddress_eth1'],
      ports             => '80',
      options           => 'check'
    }

  }



}
