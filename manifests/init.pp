#
# jetty module
#
# Copyright 2008, Puzzle ITC
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

# modules_dir { \"jetty\": }

class jetty {
    include jetty::base
}

class jetty::base {
    # we put rpms from http://dist.codehaus.org/jetty/jetty-6.1.11/rpms/
    # in our own repo
    package{ ['jetty6', 'jetty6-core', 'jetty6-servlet-2.5-api' ]:
        ensure => present,
    }

    file{'/etc/jetty6/jetty.xml':
        source => [ "puppet://$server/files/jetty/config/${fqdn}/jetty.xml",
                    "puppet://$server/files/jetty/config/jetty.xml",
                    "puppet://$server/jetty/config/jetty.xml" ],
        require => Package['jetty6'],
        notify => Service['jetty6'],
        owner => root, group => 0, mode => 0644;
    }

    file{'/etc/jetty6/jetty-ssl.xml':
        source => [ "puppet://$server/files/jetty/config/${fqdn}/jetty-ssl.xml",
                    "puppet://$server/files/jetty/config/jetty-ssl.xml",
                    "puppet://$server/jetty/config/jetty-ssl.xml" ],
        require => Package['jetty6'],
        notify => Service['jetty6'],
        owner => root, group => 0, mode => 0644;
    }

    
    # original jetty6 lacks some good features for chkconfig
    # and hasstatus
    file{'/etc/init.d/jetty6':
        source => "puppet://$server/jetty/init.d/jetty6",
        require => Package['jetty6'],
        before => Service['jetty6'],
        owner => root, group => 0, mode => 0755;
    }

    service{'jetty6':
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package['jetty6'],
    }
}
