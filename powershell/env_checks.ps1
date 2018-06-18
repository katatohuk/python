########################################################################
## Sanity checks for Execution servers
## 1) Check D: drive availability and space
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
                Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object CSName, Caption | Sort-Object -Property CSName | where {$_.Caption -in "Microsoft Windows Server 2012 R2 Standard", "Microsoft Windows Server 2016 Standard"}
                }

#Check disk size by drive letter
function disk {[cmdletbinding()]
               param ([string]$drive,[array]$server) 
               Write-Host ('-----------------------------------------------------')
               Write-Host ('Server: ' + $server)
               $check = Invoke-Command -ComputerName $server -ArgumentList $drive -ScriptBlock {param ($drive) Get-WmiObject Win32_logicaldisk | select -Property DeviceId, @{Name='GB'; Expression={[math]::round($_.size/1GB, 2)}} | where -Property DeviceId -eq $drive} 
               $check  
                       }

#disk -drive D: -server DK01SV8140 -Debug


#Pagefile checks for Windows 2012
function pagefile_12 {
                    param ([array]$servers)
                    #Checking AutomaticManagedPagefile status
                    Write-Host ('-----------------------------------------------------')        
                    Write-Host ('Server: ' + $servers)
                    Write-Host -NoNewline ('OS version: ') 
                    Get-CimInstance Win32_OperatingSystem -ComputerName $servers| Select-Object -ExpandProperty Caption
                    $win12_check = Invoke-Command -ComputerName $servers -ScriptBlock {Get-WmiObject -Class Win32_ComputerSystem | fl AutomaticManagedPagefile} | Out-String
                    $win12_check = $win12_check.Trim()
                    $win12_check
                    Write-Host ('')
                        if ($win12_check -match 'AutomaticManagedPagefile : True')
                    {
                        Write-Host -ForegroundColor Green ('OK')
                    }
                            else
                                {
                                    Write-Host -ForegroundColor Red ('Oops, please check pagefile settings manually')
            
                                }
        }                        
                    


#Pagefile checks for Windows 2016
function pagefile_16 {
                    param ([array]$servers)
                    #Checking AutomaticManagedPagefile status
                    Write-Host ('-----------------------------------------------------')
                    Write-Host ('Server: ' + $servers)
                    Write-Host -NoNewline ('OS version: ') 
                    Get-CimInstance Win32_OperatingSystem -ComputerName $servers | Select-Object -ExpandProperty Caption
                    $win16_check_1 = Invoke-Command -ComputerName $servers -ScriptBlock {Get-WmiObject -Class Win32_ComputerSystem | fl AutomaticManagedPagefile} | Out-String
                    $win16_check_1 = $win16_check_1.Trim()
                    $win16_check_1
                    #Checking pagefile allocated to 65Gb
                    $win16_check_2 = Invoke-Command -cn $servers -ScriptBlock {Get-ItemProperty -Path Registry::'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' | Select-Object -ExpandProperty PagingFiles}
                    $win16_check_2 = $win16_check_2.Trim()
                    $win16_check_2
                    Write-Host ('')
                      if ($win16_check_1 -match 'AutomaticManagedPagefile : False' -and $win16_check_2 -match 'C:\\pagefile.sys 65536 65536')
                    {
                        Write-Host -ForegroundColor Green ('OK')
                    }
                            else
                                {
                                    Write-Host -ForegroundColor Red ('Oops, please check pagefile settings manually')
                                }
                }



# Run loop for all servers in array
foreach($server in $servers)
{$os_ver = os_ver $server
     if($os_ver.Caption -match 'Microsoft Windows Server 2012 R2 Standard')
        {
            pagefile_12 $os_ver.CSName
        }
            elseif ($os_ver.Caption -match 'Microsoft Windows Server 2016 Standard')
                {
                    pagefile_16 $os_ver.CSName
                }
}


#Check D: drive
foreach($server in $servers)
{$check_d = disk D: $server
     if($check_d.GB -gt 15)
        {
            Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is ')
            Write-host -ForegroundColor Green ('OK')
        }
            else {Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is')
                  Write-host -ForegroundColor Red ( ' NOT ok')}
}


#Check regional setting are set to Denmark
foreach($server in $servers)
{$locale = invoke-Command -cn $server -ScriptBlock {write-host $env:COMPUTERNAME; get-culture } | select -ExpandProperty name
    if($locale -eq 'da-DK')
       {
        Write-Host -ForegroundColor Green ('Regional settings are OK')
       } 
            else{Write-host -ForegroundColor Red ( 'NOT ok')}
}