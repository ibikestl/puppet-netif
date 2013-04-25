# /etc/puppet/modules/netif/manifests/alias.pp
# Handle alias device type configuration
#

define netif::alias ( $ifaddr, $onparent, $onboot = "yes" )
{   
    $ifname = $name
    # filename
    $alias_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # set up interface alias ifcfg file
    file { "$alias_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/alias.erb"),
        notify   => Service[network] ,
    } 
  
}
