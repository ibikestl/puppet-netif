# /etc/puppet/modules/netif/route.pp
# Handle static route creation
# routes are passed as an array of hashes. Struct is in the form:
# [
#   {
#      # remote network
#      address => '10.20.30.0/24' ,
#      gateway => '10.1.2.1' ,
#   }
#   {
#      # local network
#      address => '10.20.30.0/24' ,
#   }
#   {
#      # remote host
#      address => '10.20.30.40/32' ,
#      gateway => '10.1.2.1' ,
#   }
#   {
#      # local host
#      address => '10.20.30.40/32' ,
#   }

define netif::route ( $routes = [] )
{
    $interface  = $name
    $route_file = "/etc/sysconfig/network-scripts/route-${name}"
    
    file { "$route_file" :
        mode     => 644 ,
        owner    => root ,
        group    => root ,
        # backup   => sysconfig
        ensure   => file ,
        content  => template("netif/route.erb"),
        notify   => Service[network] ,
    }
}
