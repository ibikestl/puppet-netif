# /etc/puppet/modules/netif/manifests/tap.pp
# Handle tap virtual device type configuration
#

define netif::tap ( $ifaddr, $onboot = "yes" )
{

    $ifname = $name
    # filename
    $tap_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # make sure the package is installed  
    package { tunctl:
        ensure => installed
    }
   
    # set up tap ifcfg file
    file { "$tap_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/tap.erb"),
        notify   => Service[network] ,
    } 
  
}
