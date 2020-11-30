# set to $false if running in SCOM widget; $true if in PowerShell:
$interactive = $false

$allGW = Get-SCOMManagementServer | ? {$_.IsGateway -eq $true}

foreach ($oneGW in $allGW) {
    $currentGW = $oneGW.PrincipalName
    $primaryMS = ($oneGW.GetPrimaryManagementServer()).PrincipalName
    $failoverMS = ($oneGW.GetFailoverManagementServers()).PrincipalName

    if ($interactive) {
        "-"*50
        $currentGW
        $primaryMS
        $failoverMS
    } else {
        $dataObject = $ScriptContext.CreateInstance("xsd://foo!bar/baz")
        $dataObject["Id"] = [String]($currentGW)
        $dataObject["Gateway"] = [String]($currentGW)
        $dataObject["Primary MS"] = [String]($primaryMS)
        $dataObject["Failover MS"] = [String]($failoverMS)
        $ScriptContext.ReturnCollection.Add($dataObject)
    }
}