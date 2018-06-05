Write-Host ('Enable powershell on all servers using psexec tool before configuring')
\\dk01sn008\Test\Temp\KMY\pstool\psexec -accepteula -d  @\\dk01sn008\Test\Temp\rmnm\ex64.txt  -u scdom\pdtau -p TAUadmin1 -s powershell Enable-PSRemoting -Force

#set all servers list into variable
$servers = Get-Content \\dk01sn008\Test\Temp\RMNM\ex64.txt

Write-Host ('Below will check OS version adn depending on that apply different pagefile settings:
### for Win12 servers sets pagefile allocation to Auto
### for Win16 servers sets pagefile allocation to 65Gb')


$os_ver = $var = Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object CSName, Caption | Sort-Object -Property CSName | where {$_.Caption -in "Microsoft Windows Server 2012 R2 Standard", "Microsoft Windows Server 2016 Standard"}
foreach($server in $os_ver)
{
    if ($server -match 'Microsoft Windows Server 2012 R2 Standard')
        {
            # Changing pagefile setting to auto 
            Invoke-Command -ComputerName $server -ScriptBlock {wmic computersystem set AutomaticManagedPagefile=true}
        }
             elseif ($server -match 'Microsoft Windows Server 2016 Standard')
                {
                    #Ensure you turned off auto pagefile sizing by sytem, otherwise below 2 commands won't work at all throwing exceptions
                    Invoke-Command -ComputerName $server -ScriptBlock {wmic computersystem set AutomaticManagedPagefile=false}
                    #Setting pagefile allocation to 65Gb
                    Invoke-Command -ComputerName $server -ScriptBlock {wmic.exe pagefileset where name="'C:\\pagefile.sys'" set 'InitialSize=65536,MaximumSize=65536'}
                }
                    }

Write-host ('Pushing all servers to restart')
Invoke-Command -ComputerName $servers -ScriptBlock {shutdown -r -f -t 1}
Write-host ('Waiting while servers are being restarted for 5 mins and only then proceed')
$x = 5*60
$length = $x / 100
while($x -gt 0) {
  $min = [int](([string]($x/60)).split('.')[0])
  $text = " " + $min + " minutes " + ($x % 60) + " seconds left"
  Write-Progress "Waiting for servers being restarted and then proceed" -status $text -perc ($x/$length)
  start-sleep -s 1
  $x--
}

Write-Host ('Checking if servers are up and running')
foreach($server in $servers)
{
    if(!(Test-Connection -Cn $server -BufferSize 16 -Count 1 -ea 0 -quiet))
        { 
            Write-Host ('Server ' + $server + ' seems to be down')
        }
            else
                {
                    Write-Host ('Server ' + $server + ' is up and running')
                }
}

Read-Host -Prompt 'Press any key if you see that all servers are OK, if not, please press CTRL+Z combination to terminate script and investigate server accessibility issues'



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




## Sanity checks
Write-Output ('Performing sanity checks')    
