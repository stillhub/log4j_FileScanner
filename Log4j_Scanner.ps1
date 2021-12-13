Import-Module ActiveDirectory
$ServerLog = "C:\temp\Servers_Log4j.csv"
$ServerList = Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"' | Select Name

foreach($Server in $ServerList){
    Write-Host "Scanning:" $SERVER.Name
    Invoke-Command -ComputerName $SERVER.Name -ScriptBlock {get-childitem C:\log4j*.jar -Recurse} | Export-CSV $ServerLog -notypeinformation -append
}
