puppet-netif
============

Puppet module for managing network interfaces and static routes on 
RHEL/CentOS flavors of Linux. Requires the puppet stdlib module.

Interfaces are defined via the netif::inferface defined type. Arguments are:

* name
    * Name of the interface. Type is automatically determined by the name.
* ifaddr
    * IP address of interface.
* aliases
    * An array of IPv4 addresses to add as aliases (CIDR notation).
* ifaddr6
    * IPv6 address of interface (currently only works on primary interfaces).
* aliases6
    * An array of IPv6 addresses to add as aliases.
* onboot
    * yes/no. Default is yes.
* onparent
    * yes/no. For vlan, pkey, and aliased interfaces. Default is yes.
*  mtu
    * MTU value for the interface. Defaults are:
        * eth: 1500
        * ib: 2044
* routes
    * Array of hashes. Key/values of the hash are:
        * address: address/bitmask of the target network. The default
          route has the address 0.0.0.0/0.
        * gateway: gateway to target network. If this is undefined, the
          target network is a different IP subnet on the same physcial subnet.
* routes6 (currently only works on primary interfaces).
    * Same as `routes`, but for IPv6.
* slave
    * Array of slave interface names for bridge interfaces.

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

eth0 including default routes and aliases:

<pre><code>
netif::interface { 'eth0' :
    # address/netmask
    ifaddr => "1.2.3.4/24" ,
    aliases => ["1.2.3.5/24", "1.2.3.10/24"] ,
    ifaddr6 => "abc:123:def:456::9a3/64" ,
    aliases6 => ["abc:123:def:456::9b7/64", "abc:123:def:456::a48/64"] ,
    routes => [
        {
            # this interface has the default route
            address => '0.0.0.0/0' ,
            gateway => '1.2.3.1' ,
        } ,
    ] ,
    routes6 => [
        {
            # this interface has the default route
            address => '::/0' ,
            gateway => 'abc:123:def:456::1' ,
        } ,
    ] ,
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


