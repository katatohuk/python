#Enable powershell on all servers using psexec tool before configuring
\\dk01sn008\Test\Temp\KMY\pstool\psexec -accepteula -d  @\\dk01sn008\Test\Temp\rmnm\ex64.txt  -u scdom\pdtau -p TAUadmin1 -s powershell Enable-PSRemoting -Force

#set all servers list into variable
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt

# Below will check OS version adn depending on that apply differeny pagefile settings:
# ---- for Win12 servers only set pagefile allocation to Auto
# ---- for Win16 servers sets pagefile to 65Gb

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


#Install Tivoli agent
$servers = Get-Content \\dk01sn008\Test\Temp\ADPK\servers_install_agent.txt
foreach($server in $servers)
{
    Write-Output ('Copying bat file to machine ' + $server)
    cp -path \\dk01sn008\Test\Technical\Batch\TWS\Deployment\Install_Prod_Environment_Agent\create_client_93_PROD_environment.bat -Destination \\$server\C$\temp\
}
Invoke-Command -ComputerName $servers -ScriptBlock {C:\Temp\create_client_93_PROD_environment.bat}


# for now only workis via psexec
\\dk01sn008\Test\Temp\KMY\pstool\psexec -accepteula -d  @\\dk01sn008\Test\Temp\ADPK\servers_install_agent.txt  -u scdom\pdtau -p TAUadmin1 -s "C:\temp\create_client_93_PROD_environment.bat"

#Install MQ client
#Copy installer to remote system first
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt
foreach($server in $servers)
{
    Write-Output ('Copying Crystal Reports installer to machine ' + $server)
    cp -path "\\dk01snt899\Software\IBM\WebSphere 7.0.1.2\" -Recurse -Destination  \\$server\C$\temp\mq   
}

#
#Install package
foreach($server in $servers)
{
$s = New-PSSession -ComputerName $server
Write-Host ('Running remotely on: ' + $server)
$s | ft
Invoke-Command -Session $s -ScriptBlock {msiexec /i "C:\Temp\mq\WebSphere 7.0.1.2\Windows\MSI\IBM WebSphere MQ.msi" /qn TRANSFORMS="1033.mst" AGREETOLICENSE="yes" /log C:\MSIInstall_MQ.log}
}
Get-PSSession | Remove-PSSession

#
#Double check if package was installed
Invoke-Command -ComputerName $servers -ScriptBlock {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | where {$_.DisplayName -like "*MQ*"}} | Sort-Object -Property PSComputerName
#or this one
foreach($server in $servers)
{
   if (Invoke-Command -ComputerName $server -ScriptBlock {Test-Path -path "C:\Program Files (x86)\IBM\WebSphere MQ"})
    {
    Write-host -ForegroundColor Green ($server + ' is OK')
    }   
   else
        {
            Write-Host -ForegroundColor Red ($server + ' IS NOT OK')
        } 
}

#Install Crystal Reports
#Copy installer to remote system first
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt
foreach($server in $servers)
{
    Write-Output ('Copying installer file to machine ' + $server)
    cp -path \\Dk01sn017\imsdev\Dev\Release\AddOns\CrystalSetup\CRforVS_clickonce_13_0_16\CRforVS_clickonce_13_0_16\CRRuntime_64bit_13_0_16.msi -Destination \\$server\C$\temp\
}

#
#Install pacakge
foreach($server in $servers)
{
$s = New-PSSession -ComputerName $server
Write-Host ('Running remotely on: ' + $server)
#$s | ft
Invoke-Command -Session $s -ScriptBlock {msiexec /i c:\temp\CRRuntime_64bit_13_0_16.msi /qn /log C:\MSIInstall.log}
}
#close all current active PSSessions to free up resources
Get-PSSession | Remove-PSSession

#
#check if folder created
foreach($server in $servers)
{
    Write-Output ($server + ': ')
    Invoke-Command -ComputerName $server -ScriptBlock {Test-Path -path "C:\Program Files (x86)\SAP BusinessObjects"} 
}


#
#Setting up MQSERVER variable
Write-Output ("Setting up system variable MQSERVER")
Invoke-Command -ComputerName $servers -ScriptBlock {
[Environment]::SetEnvironmentVariable("MQSERVER", "S_dk01tst014/TCP/dk01tst014", "Machine")
[Environment]::GetEnvironmentVariable("MQSERVER","Machine")
    }