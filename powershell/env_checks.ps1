########################################################################
## Sanity checks for Execution servers
## 1) Check D: drive availability and size
## 2) Check regional settings
## 3) Check pagefile settings
## 4) Check TWS agent installed, registered on Tivoli server and running
## 5) Check MQ client installed
## 6) Check Crystal report installed
## 7) Net.Framework  installed
########################################################################



$servers = Get-Content \\dk01sn008\Test\Temp\ADPK\dk01sv8088.txt

Write-host -Backgroundcolor 'Black' ('###########################')
Write-host -Backgroundcolor 'Black' (' Performing sanity checks')
Write-host -Backgroundcolor 'Black' ('###########################')


#
# Functions go here
#

#Get Windows version
function os_ver { 
                param ([array]$servers)
                Get-CimInstance Win32_OperatingSystem -ComputerName $server | Select-Object CSName, Caption | Sort-Object -Property CSName | where {$_.Caption -in "Microsoft Windows Server 2012 R2 Standard", "Microsoft Windows Server 2016 Standard"}
                }

#Check disk size by drive letter
function disk {[cmdletbinding()]
               param ([string]$drive) 
               #Write-Host ('-----------------------------------------------------')
               #Write-Host ('Server: ' + $server.ToUpper())
               $check = Invoke-Command -ComputerName $server -ArgumentList $drive -ScriptBlock {param ($drive) Get-WmiObject Win32_logicaldisk | select -Property DeviceId, @{Name='GB'; Expression={[math]::round($_.size/1GB, 2)}} | where -Property DeviceId -eq $drive} 
               $check  
                       }


#Pagefile checks for Windows 2012
function pagefile_12 {
                    param ([array]$servers)
                    #Checking AutomaticManagedPagefile status
                    #Write-Host ('-----------------------------------------------------')        
                    #Write-Host ('Server: ' + $servers)
                    Write-Host -NoNewline ('OS version: ') 
                    Get-CimInstance Win32_OperatingSystem -ComputerName $server | Select-Object -ExpandProperty Caption
                    $win12_check = Invoke-Command -ComputerName $server -ScriptBlock {Get-WmiObject -Class Win32_ComputerSystem | fl AutomaticManagedPagefile} | Out-String
                    $win12_check = $win12_check.Trim()
                    $win12_check
                    Write-Host ('')
                        if ($win12_check -match 'AutomaticManagedPagefile : True')
                    {
                        Write-Host -NoNewline ('Pagefile settings: ')
                        Write-Host -ForegroundColor Green ('OK')
                    }
                            else
                                {
                                    Write-Host -NoNewline ('Pagefile settings: ')
                                    Write-Host -ForegroundColor Red ('Oops, please check pagefile settings manually')
            
                                }
        }                        
                    


#Pagefile checks for Windows 2016
function pagefile_16 {
                    param ([array]$servers)
                    #Checking AutomaticManagedPagefile status
                    #Write-Host ('-----------------------------------------------------')
                    #Write-Host ('Server: ' + $servers)
                    Write-Host -NoNewline ('OS version: ') 
                    Get-CimInstance Win32_OperatingSystem -ComputerName $server | Select-Object -ExpandProperty Caption
                    $win16_check_1 = Invoke-Command -ComputerName $server -ScriptBlock {Get-WmiObject -Class Win32_ComputerSystem | fl AutomaticManagedPagefile} | Out-String
                    $win16_check_1 = $win16_check_1.Trim()
                    $win16_check_1
                    #Checking pagefile allocated to 65Gb
                    $win16_check_2 = Invoke-Command -cn $server -ScriptBlock {Get-ItemProperty -Path Registry::'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' | Select-Object -ExpandProperty PagingFiles}
                    $win16_check_2 = $win16_check_2.Trim()
                    $win16_check_2
                    Write-Host ('')
                      if ($win16_check_1 -match 'AutomaticManagedPagefile : False' -and $win16_check_2 -match 'C:\\pagefile.sys 65536 65536')
                    {
                        Write-Host -NoNewline ('Pagefile settings: ')
                        Write-Host -ForegroundColor Green ('OK')
                    }
                            else
                                {
                                    Write-Host -NoNewline ('Pagefile settings: ')
                                    Write-Host -ForegroundColor Red ('Oops, please check pagefile settings manually')
                                }
                }


#Check .NET Framework version installed
function net_framework {
    param ([array]$servers)
        $dotNet4Builds = @{
        30319  = '.NET Framework 4.0'
        378389 = '.NET Framework 4.5'
        378675 = '.NET Framework 4.5.1'
        378758 = '.NET Framework 4.5.1'
        379893 = '.NET Framework 4.5.2' 
        393295 = '.NET Framework 4.6'
        393297 = '.NET Framework 4.6'
        394254 = '.NET Framework 4.6.1'
        394271 = '.NET Framework 4.6.1'
        394747 = '.NET Framework 4.6.1'
        394748 = '.NET Framework 4.6.1)'
        394802 = '.NET Framework 4.6.2'
        460798 = '.NET Framework 4.7'
        460805 = '.NET Framework 4.7'
        461308 = '.NET Framework 4.7.1'
        461310 = '.NET Framework 4.7.1'
        461808 = '.NET Framework 4.7.2'
        461814 = '.NET Framework 4.7.2'
        }
        
Invoke-Command -cn $server -ScriptBlock {Get-ItemPropertyValue 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\' -Name Release}
}

# Check software is installed
function is-installed ($program) {
                                    Invoke-Command -ComputerName $server -ArgumentList $program -ScriptBlock {param($program)
                                                                                       $x86 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*  | 
                                                                                       Select-Object DisplayName | where {$_.DisplayName -like "*$program*"};
                                                                                       $x64 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*  | 
                                                                                       Select-Object DisplayName | where {$_.DisplayName -like "*$program*"};
                                                                                       #$x86 -or $x64;}
                                                                                       $x86
                                                                                       $x64 }
}

#is-installed sap

# Run loop for all servers in array
foreach($server in $servers)
{
Write-Host ('')
Write-Host ('-----------------------------------------------------')
Write-Host -ForegroundColor darkYellow ('Checking Pagefile status')
$os_ver = os_ver $server
     if($os_ver.Caption -match 'Microsoft Windows Server 2012 R2 Standard')
        {
            pagefile_12 $os_ver.CSName
        }
            elseif ($os_ver.Caption -match 'Microsoft Windows Server 2016 Standard')
                {
                    pagefile_16 $os_ver.CSName
                }
Write-Host ('')
Write-Host ('-----------------------------------------------------')
Write-Host -ForegroundColor darkYellow ('# Checking drive D:\ status')
$check_d = disk D:
     if($check_d.GB -gt 14)
        {
            Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is ')
            Write-host -ForegroundColor Green ('OK')
        }
            else {Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is')
                  Write-host -ForegroundColor Red ( ' NOT ok')}
Write-Host ('')
Write-Host ('-----------------------------------------------------')
Write-Host -ForegroundColor darkYellow ('Checking locale')
$locale = invoke-Command -cn $server -ScriptBlock {get-culture } | select -ExpandProperty name
    if($locale -eq 'da-DK')
       {
        Write-Host -NoNewline ('Regional settings:')
        Write-Host -ForegroundColor Green (' OK')
       } 
            else{
            Write-Host -NoNewline ('Regional settings:')
            Write-host -ForegroundColor Red ( 'NOT ok')}
Write-Host ('')
Write-Host ('-----------------------------------------------------')
Write-Host -ForegroundColor darkYellow ('Checking .NET Framework version installed')
$checkfx = net_framework $server
     $dotNet4Builds[$checkfx]   
Write-Host ('')
Write-Host ('-----------------------------------------------------')
Write-Host -ForegroundColor darkYellow ('Checking IBM Websphere MQ is installed')
$checkmq = is-installed IBM Websphere MQ
if($checkmq -eq $true)
    {Write-Host -ForegroundColor Green ('OK')}
        else{Write-host -ForegroundColor Red ( 'NOT ok')}
Write-Host ('')
Write-Host ('-----------------------------------------------------')
Write-Host -ForegroundColor darkYellow ('Checking Crystal Reports is installed')
$checksap = is-installed wot
if($checksap -eq $true)
    {Write-Host -ForegroundColor Green ('OK')}
        else{Write-host -ForegroundColor Red ( 'NOT ok')}       
}

