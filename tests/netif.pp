# tap virtual interface
netif::interface { 'tap0' :
    ifaddr => "172.24.0.14/28" ,
}        

# regular ethernet with lots of routes
netif::interface { 'eth1' :
    ifaddr => "10.1.2.99/24" ,
    routes => [
        {
            address => '10.40.30.0/24' ,
            gateway => '10.1.2.1' ,
        } ,
        {
            address => '10.40.40.0/24' ,
        } ,
        {
            address => '10.40.50.60/32' ,
        } ,
        {
            address => '10.40.60.60/32' ,
            gateway => '10.1.2.2' ,
        } ,
    ],
}

# regular ethernet with default route
netif::interface { 'eth0' :
    ifaddr => '10.50.50.8/28' ,
    routes => [
        {
            address => '0.0.0.0/0' ,
            gateway => '10.50.50.1' ,
        }
    ] ,
}

# aliased interface
netif::interface { 'eth1:1' :
    ifaddr => "10.2.2.99/24" ,
}

# vlan interface
netif::interface { 'eth1.3754' :
    ifaddr => "10.2.3.99/24" ,
}

# infiniband
netif::interface { 'ib0' :
    ifaddr => "192.168.76.99/24"
}

# infiniband with pkey
netif::interface { 'ib0.8123' :
    ifaddr => "192.168.77.99/24"
}

# infiniband alias
netif::interface { 'ib0:1' :
    ifaddr => "192.168.78.99/24"
}

# bridge
netif::interface { 'br0' :
    ifaddr => "192.168.99.99/24" ,
    slaves => ['eth2','eth3','eth4','eth5'] ,
}
    

# ethernet vlan with different mtu for jumbo frames
netif::interface { 'eth1.3754' :
    ifaddr => "10.2.4.99/24" ,
    mtu    => "9000" ,
}

