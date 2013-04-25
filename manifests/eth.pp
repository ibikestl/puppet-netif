# /etc/puppet/modules/netif/manifests/eth.pp
# handle ethernet and VLAN ethernet device type configuration
#

define netif::eth ($ifaddr = "", $ifaddr6 = "", $aliases = [], $aliases6 = [], $onboot = "yes" , $mtu = "1500")
{
    $ifname = $name
    # filename
    $eth_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # set up regular eth ifcfg file
    file { "$eth_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/eth.erb"),
        notify   => Service[network] ,
    } 
  
}

define netif::eth_vlan ($ifaddr = "", $onboot = "yes" , $mtu = "1500")
{
    $ifname = $name
    # filename
    $eth_file = "/etc/sysconfig/network-scripts/ifcfg-${ifname}"

    # set up vlan eth ifcfg file
    file { "$eth_file":
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/eth_vlan.erb"),
        notify   => Service[network] ,
    } 
}

