#Enable powershell on all servers using psexec tool before configuring
\\dk01sn008\Test\Temp\KMY\pstool\psexec -accepteula -d  @\\dk01sn008\Test\Temp\rmnm\ex64.txt  -u scdom\pdtau -p TAUadmin1 -s powershell Enable-PSRemoting -Force

#set all servers list
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt

# for Win12 servers only set pagefile allocation to Auto

$servers_12 = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64_12.txt
#Invoke-Command -ComputerName $servers_12 -ScriptBlock {wmic.exe pagefile list /format:list}
#check the status of pagefile settings
Invoke-Command -ComputerName $servers_12 -ScriptBlock {Get-WmiObject -Class Win32_ComputerSystem | fl AutomaticManagedPagefile}
#Change pagefile setting to auto
Invoke-Command -ComputerName $servers_12 -ScriptBlock {wmic computersystem set AutomaticManagedPagefile=true}

#For Win16 servers pagfile size has to be setup manually
$servers_16 = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64_16.txt
#Ensure you turned off auto pagefile sizing by sytem, otherwise below 2 commands won't work at all throwing exceptions
Invoke-Command -ComputerName $servers_16 -ScriptBlock {wmic computersystem set AutomaticManagedPagefile=false}
#check the status of pagefile settings
Invoke-Command -ComputerName $servers_16 -ScriptBlock {Get-WmiObject -Class Win32_ComputerSystem | fl AutomaticManagedPagefile}
#Check size parameters
Invoke-Command -ComputerName $servers_16 -ScriptBlock {wmic.exe pagefileset where name="'C:\\pagefile.sys'" list /format:list}
#Set pagefile size to 65Gb
Invoke-Command -ComputerName $servers_16 -ScriptBlock {wmic.exe pagefileset where name="'C:\\pagefile.sys'" set 'InitialSize=65536,MaximumSize=65536'}


#Restart all servers
Invoke-Command -ComputerName $servers -ScriptBlock {shutdown -r -f -t 1}
#Check last boot time to ensure all were rebooted
Invoke-Command -ComputerName $servers -ScriptBlock {Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime}

#Uninstall Tivoli agent
Invoke-Command -ComputerName servername -ScriptBlock {cscript C:\TwsInst\TWS\twsinst.vbs -uninst -uname pdtau}