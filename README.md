puppet-netif
============

Puppet module for managing network interfaces and static routes on RHEL/CentOS flavors of Linux

Interfaces are defined via the netif::inferface defined type. Arguments are:
<p>
>   name:     
>>  Name of the interface. Type is automatically determined by the name.
>   ifaddr:   
>>  IP address of interface 
>   onboot:   
>>  yes/no. Default is yes
>   onparent: 
>>  yes/no. For vlan, pkey, and aliased interfaces. Default is yes.
>   mtu:      
>>  MTU value for the interface. Defaults are:
>>  eth: 1500
>>  ib:  2044
>   routes:   
>>  Array of hashes. Key/values of the hash are:
>>> address: address/bitmask of the target network. The default
>>> route has the address 0.0.0.0/0
>>> gateway: gateway to target network. If this is undefined, the
>>> target network is a different IP subnet on the same physcial
>>> subnet.
>   slaves:   
>   Array of slave interface names for bridge interfaces.
<p>

Supported interface types:
> Ethernet
> Ethernet VLAN
> Infiniband
> Infiniband with Partition Keys (pkey)
> Aliased interfaces
> Bridge interfaces, including slaves
> Tap virtual interfaces

Usage example:

eth0 including default routes:

<pre><code>
netif::interface { 'eth0' :
    # address/netmask
    ifaddr => "1.2.3.4/24" ,
    routes => [
        {
            # this interface has the default route
            address => '0.0.0.0/0' ,
            gateway => '1.2.3.1' ,
        } ,
    ]
}
</code></pre>

eth0.2347 VLAN interface with a route to another network:

<code><pre>
netif::interface { 'eth0.2347' :
    # address/netmask
    ifaddr => "1.2.4.4/24" ,
    routes => [
        {
            # route to remote network
            addresss => '10.2.3.4/24' ,
            gateway  => '1.2.3.1' ,
        } ,
    ]
}
</code></pre>

br0 with slaves eth2-eth5 with a route to an overlay network:

<code></pre>
netif::interface { 'br0' :
    # address/netmask
    ifaddr => "1.2.5.4/24" ,
    slaves => ['eth2','eth3','eth4','eth5'] ,
    routes => [
        {
            # route to network on the same physical subnet
            addresss => '10.2.4.0/28' ,
        } ,
    ]
}
</code></pre>


