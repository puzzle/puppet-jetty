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
    service{'jetty6':
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package['jetty6'],
    }
}
