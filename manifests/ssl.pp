# manifests/ssl.pp
# enabled ssl for jetty
class jetty::ssl {
    file{'/etc/jetty6/jetty-ssl.xml':
        source => [ "puppet://$server/files/jetty/config/${fqdn}/jetty-ssl.xml",
                    "puppet://$server/files/jetty/config/jetty-ssl.xml",
                    "puppet://$server/jetty/config/jetty-ssl.xml" ],
        require => Package['jetty6'],
        notify => Service['jetty6'],
        owner => root, group => 0, mode => 0644;
    }

    line { enable_jetty_ssl:
        file => '/etc/jetty6/jetty.conf',
        line => '/etc/jetty6/jetty-ssl.xml',
        ensure => present,
        notify => Service['jetty6'],
        require => File['/etc/jetty6/jetty-ssl.xml'],
  }
}

