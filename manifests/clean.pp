# manifests/clean.pp

class jetty::clean {
    # ensure that default files are absent
    file{ [ '/var/lib/jetty6/contexts/README.TXT',
            '/var/lib/jetty6/contexts/test.d',
            '/var/lib/jetty6/contexts/test.xml',
            '/var/lib/jetty6/webapps/cometd.war',
            '/var/lib/jetty6/webapps/README.TXT',
            '/var/lib/jetty6/webapps/test' ]:
        ensure => absent,
        purge => true,
        force => true,
        require => Package['jetty6'],
        notify => Service['jetty6'],
    }
}
