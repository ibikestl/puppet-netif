# /etc/puppet/modules/netif/manifests/br.pp
# Handle bridge device type configuration
#

# slaves are passed as an array, so set up multiple slave files
define netif::br::slave () {
    file { "/etc/sysconfig/network-scripts/ifcfg-${name}":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/br_slave.erb"),
    }
}

define netif::br ( $ifaddr, $slaves , $onboot = "yes" , $mtu = "1500")
{
    $ifname = $name
    $br_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # make sure the bridge-utils package is installed  
    package { bridge-utils:
        ensure => installed
    }
   
    # set up bridge master file
    netif::br::slave { $slaves: } -> file { "$br_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/br.erb"),
        notify   => Service[network] ,
    }

  
}
