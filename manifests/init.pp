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

		if $operatingsystemmajrelease == '7' {
			$pkg = "arptables"

			file { 
				'/etc/sysconfig/arptables':
					content => template("arptables/arptables_centos7.erb"),
					owner => 'root', group => 'root',
					notify => Service[$pkg],
					ensure => 'file';
			}


		} else {
			$pkg = "arptables_jf"

			file { 
				'/etc/sysconfig/arptables':
					content => template("arptables/arptables.erb"),
					owner => 'root', group => 'root',
					notify => Service[$pkg],
					ensure => 'file';
			}


		}


		package { 
		    $pkg: ensure => present;
		}

		service { 
		    $pkg:
			 enable => 'true',
		   	 ensure => 'running';
		}
	}
}
