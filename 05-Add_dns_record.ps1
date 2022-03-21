# 정방향 조회 도메인 만들기 
# Add-DnsServerPrimaryZone -Name "vclass.local" -ZoneFile "vclass.local.dns"

# 역방향 조회 도메인 만들기 
Add-DnsServerPrimaryZone -NetworkID 10.10.1.0/24 -ZoneFile "1.10.10.in-addr.arpa.dns"

# DNS 포워딩 
# Add-DnsServerForwarder -IPAddress 172.0.10.2 -PassThru

# Domain Controller Record
Add-DnsServerResourceRecordA -Name "sa-vcsa-01" -ZoneName "vclass.local" -IPv4Address "10.10.1.10"
Add-DnsServerResourceRecordPtr -Name "10" -ZoneName "1.10.10.in-addr.arpa" -PtrDomainName "sa-vcsa-01.vclass.local"

Add-DnsServerResourceRecordA -Name "sa-esxi-01" -ZoneName "vclass.local" -IPv4Address "10.10.1.11"
Add-DnsServerResourceRecordPtr -Name "11" -ZoneName "1.10.10.in-addr.arpa" -PtrDomainName "sa-esxi-01.vclass.local"

Add-DnsServerResourceRecordA -Name "sa-esxi-02" -ZoneName "vclass.local" -IPv4Address "10.10.1.12"
Add-DnsServerResourceRecordPtr -Name "12" -ZoneName "1.10.10.in-addr.arpa" -PtrDomainName "sa-esxi-02.vclass.local"

Add-DnsServerResourceRecordA -Name "sa-esxi-03" -ZoneName "vclass.local" -IPv4Address "10.10.1.13"
Add-DnsServerResourceRecordPtr -Name "13" -ZoneName "1.10.10.in-addr.arpa" -PtrDomainName "sa-esxi-03.vclass.local"
