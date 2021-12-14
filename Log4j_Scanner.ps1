Import-Module ActiveDirectory
$ServerLog = "C:\temp\Servers_Log4j.csv"
$ServerList = Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"' | Select Name

foreach($Server in $ServerList){
    Write-Host "Scanning: " $SERVER.name
    Invoke-Command -ComputerName $SERVER.Name -ScriptBlock {$DriveList = (Get-PSDrive -PSProvider FileSystem).Root; foreach($Drive in $DriveList){$Term = $Drive + "log4j*.jar"; get-childitem $Term -Recurse}} | Export-CSV $ServerLog -notypeinformation -append
    
}
