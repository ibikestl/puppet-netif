puppet-netif
============

Puppet module for managing network interfaces and static routes on RHEL/CentOS flavors of Linux

Interfaces are defined via the netif::inferface defined type. Arguments are:
<p>
*  name:<br>
   Name of the interface. Type is automatically determined by the name.<br>
*  ifaddr:   <br>
   IP address of interface <br>
*  onboot:   <br>
   yes/no. Default is yes<br>
*  onparent: <br>
   yes/no. For vlan, pkey, and aliased interfaces. Default is yes.<br>
*   mtu:      <br>
    MTU value for the interface. Defaults are:<br>
    eth: 1500<br>
    ib:  2044<br>
*   route<br>
    Array of hashes. Key/values of the hash are:<br>
    address: address/bitmask of the target network. The default<br>
    route has the address 0.0.0.0/0<br>
    gateway: gateway to target network. If this is undefined, the<br>
    target network is a different IP subnet on the same physcial<br>
    subnet.<br>
*   slave<br>
    Array of slave interface names for bridge interfaces.<br>
<p>

Supported interface types:

* Ethernet
* Ethernet VLAN
* Infiniband
* Infiniband with Partition Keys (pkey)
* Aliased interfaces
* Bridge interfaces, including slaves
* Tap virtual interfaces

----
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

<code><pre>
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


