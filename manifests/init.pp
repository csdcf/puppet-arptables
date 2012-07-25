# Class: arptables
#
# This module manages arptables
# Userspace control program for the arptables network filter
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# 
#    $suppress_arp = [ '171.64.64.64', '171.64.64.179' ]
#
#    include arptables_jf
#
# [Remember: No empty lines between comments and class definition]
class arptables ($suppress_arp = [] ) {

    if $operatingsystem in [ 'CentOS', 'fedora' ] {
        package { 
            'arptables_jf': ensure => present;
        }

        file { 
            '/etc/sysconfig/arptables':
                content => template("arptables/arptables.erb"),
                owner => 'root', group => 'root',
                notify => Service['arptables_jf'],
                ensure => 'file';
        }

        service { 
            'arptables_jf':
                enable => 'true';
        }

    }

}
