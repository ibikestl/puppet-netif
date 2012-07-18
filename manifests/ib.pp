# /etc/puppet/modules/netif/manifests/ib.pp
# handle infiniband and infiniband with pkey device type configuration
#

define netif::ib ($ifaddr = "", $onboot = "yes" , $mtu = "2044" )
{
    $ifname = $name
    # filename
    $ib_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # set up ib ifcfg file
    file { "$ib_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/ib.erb"),
        notify   => [ Service[network] , Service[openibd] ] ,
    } 
  
}

define netif::ib_pkey ($ifaddr = "", $onboot = "yes" , $mtu = "2044")
{
    $ifname = $name
    # filename
    $ib_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # set up pkey ib ifcfg file
    file { "$ib_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/ib_pkey.erb"),
        notify   => [ Service[network] , Service[openibd] ] ,
    } 
}

