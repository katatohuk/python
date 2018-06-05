# put a file with server list somewhere as in below example
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt
Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object CSName, Caption | Sort-Object -Property CSName
#the smame but with filter
Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object CSName, Caption | Sort-Object -Property CSName | where {$_.Caption -eq "Microsoft Windows 10 Enterprise"}
#Select only server names
Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object CSName, Caption | Sort-Object -Property CSName | where {$_.Caption -eq "Microsoft Windows Server 2016 Standard"} | select CSName



$var = Get-CimInstance Win32_OperatingSystem -ComputerName DK01SV9142,DK01SV9146 | Select-Object CSName, Caption | Sort-Object -Property CSName | where {$_.Caption -in "Microsoft Windows Server 2012 R2 Standard", "Microsoft Windows Server 2016 Standard"}
#$var
foreach($v in $var)
{
    if ($v -match 'Microsoft Windows Server 2012 R2 Standard')
        {
         write-host ('Win ver is 2012')
        }
             elseif ($v -match 'Microsoft Windows Server 2016 Standard')
                {
                     write-host ("Win ver is 2016")
                }
}