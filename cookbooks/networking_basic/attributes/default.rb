case node['platform']
when "debian","ubuntu"
  default['networking']['packages'] = %w[ lsof iptables jwhois whois curl wget rsync jnettop nmap traceroute ethtool iproute iputils-ping netcat-openbsd tcptraceroute tcputils tcpdump elinks lynx ]
when "redhat","centos","scientific","amazon"
  default['networking']['packages'] = %w[ lsof iptables jwhois curl wget rsync nmap traceroute ethtool iproute iputils nc tcptraceroute tcputils tcpdump elinks lynx ]
end
