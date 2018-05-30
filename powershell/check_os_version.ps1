# put a file with server list somewhere as in below example
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt
Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object CSName, Caption | Sort-Object -Property CSName