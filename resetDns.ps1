

function get-dnsAddress {
        
    $dnsConfig = Get-DnsClientServerAddress -InterfaceIndex 7

    $ipv4 = $dnsConfig | where-object {$_.AddressFamily -eq 2}

    return $ipv4.ServerAddresses
}

while(1) {

    $stopwatch =  [system.diagnostics.stopwatch]::StartNew()
    # $stopwatch.Start();

    set-dnsclientserveraddress -interfaceindex 7 -serveraddress "1.1.1.1"
    Clear-DnsClientCache

    $dns = get-dnsAddress
    
    while($dns -eq "1.1.1.1") {
        $dns = get-dnsAddress
    
        Start-Sleep -Seconds 8
    }

    $stopwatch.Stop()
    $totalSecs =  [math]::Round($stopwatch.Elapsed.TotalSeconds,0)
    write-host "Took $($totalSecs) seconds to revert to 127.0.0.1";
    
    set-dnsclientserveraddress -interfaceindex 7 -serveraddress "1.1.1.1"
    Clear-DnsClientCache

}



