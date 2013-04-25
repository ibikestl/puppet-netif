# /etc/puppet/modules/netif/route6.pp
# Handle static route creation for IPv6
# routes are passed as an array of hashes. Struct is in the form:
# [
#   {
#      # remote network
#      address => 'aaa:b:cc:d00d::/64' ,
#      gateway => 'aaa:b:cc:d00e::59a0' ,
#   }
#   {
#      # remote host
#      address => 'aaa:b:cc:d00d::89a/128' ,
#      gateway => 'aaa:b:cc:d00e::59a0' ,
#   }

define netif::route6 ( $routes = [] )
{
    $interface  = $name
    $route_file = "/etc/sysconfig/network-scripts/route6-${name}"
    
    file { "$route_file" :
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/route6.erb"),
        notify   => Service[network] ,
    }
}
