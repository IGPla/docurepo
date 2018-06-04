### TCPdump

#### Sample

```
tcpdump -i eth0 -nn -s0 -v port 80
```
- -i <interface>: tells which interface it should listen
- -n: not resolve hostnames (-nn not resolve hostnames and ports)
- -sN: snap length, the size of the packet to capture (N). Setting N=0 set the size to unlimited
- -v: verbose (-vv more verbose)

#### Display ASCII text

```
tcpdump -A -s0 port 80
```

#### Capture on protocol (example UDP, both on name and on identifier)

```
tcpdump -i eth0 udp
tcpdump -i eth0 proto 17
```

#### Capture hosts based on IP address

```
tcpdump -i eth0 host 10.10.1.1
```

#### Capture packets going one way

```
tcpdump -i eth0 dst 10.10.1.20
```

#### Write a capture file

```
tcpdump -i eth0 -s0 -w test.pcap
```

#### Extract HTTP User Agents

```
tcpdump -nn -A -s1500 -l | grep "User-Agent:"
tcpdump -nn -A -s1500 -l | egrep -i 'User-Agent:|Host:'
```

#### Capture only HTTP GET and POST packets

```
tcpdump -s 0 -A -vv 'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x47455420'
```

#### Extract HTTP Request URL's

```
tcpdump -s 0 -v -n -l | egrep -i "POST /|GET /|Host:"
```

#### Extract HTTP Passwords in POST Requests

```
tcpdump -s 0 -A -n -l | egrep -i "POST /|pwd=|passwd=|password=|Host:"
```

#### Capture Cookies from Server and from Client

```
tcpdump -nn -A -s0 -l | egrep -i 'Set-Cookie|Host:|Cookie:'
```

#### Capture all ICMP packets

```
tcpdump -n icmp
```

#### Show ICMP Packets that are not ECHO/REPLY (standard ping)

```
tcpdump 'icmp[icmptype] != icmp-echo and icmp[icmptype] != icmp-echoreply'
```

#### Capture SMTP / POP3 Email

```
tcpdump -nn -l port 25 | grep -i 'MAIL FROM\|RCPT TO'
```

#### Troubleshooting NTP Query and Response

```
tcpdump dst port 123
```

#### Capture FTP Credentials and Commands

```
tcpdump -nn -v port ftp or ftp-data
```

#### Capture IPv6 Traffic

```
tcpdump -nn ip6 proto 6
tcpdump -nr ipv6-test.pcap ip6 proto 17
```

#### Capture Start and End Packets of every non-local host

```
tcpdump 'tcp[tcpflags] & (tcp-syn|tcp-fin) != 0 and not src and dst net localnet'
```

#### Capture DNS Request and Response

```
tcpdump -i wlp58s0 -s0 port 53
```
#### Capture HTTP data packets

```
tcpdump 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
```

#### Capture with tcpdump and view in Wireshark

```
ssh root@remotesystem 'tcpdump -s0 -c 1000 -nn -w - not port 22' | wireshark -k -i -
```

#### Top Hosts by Packets

```
tcpdump -nnn -t -c 200 | cut -f 1,2,3,4 -d '.' | sort | uniq -c | sort -nr | head -n 20
```
#### Capture all the plaintext passwords

```
tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -l -A | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd=|password=|pass:|user:|username:|password:|login:|pass |user '
```
