

function get-dnsAddress {
        
    $dnsConfig = Get-DnsClientServerAddress -InterfaceIndex 7

    $ipv4 = $dnsConfig | where-object {$_.AddressFamily -eq 2}

    return $ipv4.ServerAddresses
}

$dns = get-dnsAddress

while($dns -eq "1.1.1.1") {
    $dns = get-dnsAddress

    Start-Sleep -Seconds 5
}

set-dnsclientserveraddress -interfaceindex 7 -serveraddress "1.1.1.1"

