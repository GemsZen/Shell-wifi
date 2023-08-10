# Listar senhas Wi-Fi salvas
$wifiProfiles = netsh wlan show profiles
$wifiPasswords = @()

foreach ($profile in $wifiProfiles) {
    $profileName = $profile -replace ".*\s+:\s+", ""
    $password = (netsh wlan show profile name="$profileName" key=clear | Select-String "Key Content" -Context 0,1).Context.PostContext[0] -replace "Key Content\s+:\s+", ""
    
    $wifiPasswords += [PSCustomObject]@{
        ProfileName = $profileName
        Password = $password
    }
}

$wifiPasswords | Format-Table -AutoSize