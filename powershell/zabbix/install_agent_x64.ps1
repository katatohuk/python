<#
.NAME
 Zabbix Agent Install.

.SYNOPSIS
 Copy Zabbix agent bin/conf, installs agent service and starts it.
 Run it under account which is local admin on a remote server
#>

# Script params
param([Parameter(Mandatory=$false)][array]$sl,[string]$s)

# User defined variables.
# Change below variables with your values
$SourceFolder = "\\dk01sv1364\Test\Technical\Utils\Zabbix agent_3_4_6\"
$TargetFolder = "C:\Program Files\Zabbix_agent\"
$cred = get-credential -UserName scdom\pdbaa -Message "Please enter password for account PDBAA just once"

# Logic for -sl option
if(!$sl -eq '')
    {
     # Reading content of the txt file
     $sl = get-content $sl
     foreach($server in $sl)
        {
            # Lets test if servers is online
            if (Test-Connection $server -Quiet -Count 2)
            
            {
                # Check if Zabbix Agent is installed and running, if not start the service.
                $session = New-PSSession -cn $server -Credential $cred
                Write-Host ('----------------------------------------------------------------')  
                Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $server.ToUpper())
                
                # If service is running - exit the script here
                Write-Host ('----------------------------------------------------------------')
                Write-Host 'Checking if Zabbix Agent is already installed and running'

                 If (Invoke-Command -Session $session -ScriptBlock {get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Running"})
                    {   Write-Host '.'
                        Write-Host 'Service is installed and running.'
                        Write-Host -ForegroundColor Green 'OK'
                        continue }
                    # If serice is installed but not running - try to run it and exit the damn script   
                    Elseif (Invoke-Command -Session $session -ScriptBlock {get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Stopped"}) 
                                {
                                Write-Host ('.')  
                                Write-Host 'Service detected but not started. Starting.'
                                Invoke-Command -Session $session -ScriptBlock {
                                                                                Start-Service "Zabbix Agent" -ErrorAction SilentlyContinue
                                                                                if(get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Running")
                                                                                {Write-Host -ForegroundColor Green 'OK'}
                                                                               }
                                continue
                                }
                                    
                         Else {       

            # Copy Zabbix Agent folder, Create new service, then start service.
            Write-Host ('.')  
            Write-Host 'Copying Zabbix agent from network'
            Write-Host ('.')  
            Copy-Item -Recurse -Path $SourceFolder -Destination $TargetFolder -ToSession $Session -Force 
            Write-Host 'Installing agent service'
            Write-Host ('.')  
            Invoke-Command -Session $session -ScriptBlock { 
                                                            New-Service -Name "Zabbix Agent" -BinaryPathName '"C:\Program Files\Zabbix_agent\bin\win64\zabbix_agentd.exe" --config "C:\Program Files\Zabbix_agent\conf\zabbix_agentd.win.conf"' -DisplayName "Zabbix Agent" -Description "Provides system monitoring" -StartupType "Automatic" -ErrorAction SilentlyContinue
                                                            Write-Host 'Starting service'
                                                            Start-Service -DisplayName "Zabbix Agent" -ErrorAction SilentlyContinue}
                                                           }
                                                 
            # Lets do checks now
            Write-Host ('.')  
            Write-Host 'Now lets dot some post-install checks'
            Write-Host ('.')  
            if (Invoke-Command -Session $session -ArgumentList $TargetFolder -ScriptBlock {param($TargetFolder) Test-Path $TargetFolder})
                    { Write-Host -ForegroundColor Green 'Agent folder is present.' }
                        else 
                            {Write-Host -ForegroundColor Red 'Agent folder is missing, smth went wrong during copy, please check manually'}
            If (Invoke-Command -Session $session -ScriptBlock {get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Running"})
                    { Write-Host -ForegroundColor Green 'Service is installed and running' }
                        else 
                            {Write-Host -ForegroundColor Red 'Service is missing or stopped,smth went wrong during copy, please check manually'}
                            }

            else
                    {
                    Write-Host ('----------------------------------------------------------------')  
                    Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $server.ToUpper())
                    Write-Host ('----------------------------------------------------------------')
                    write-host -ForegroundColor Red ($server + ' is unreachable')
                     }
        }
    }
          

# Logic for -s option
if(!$s -eq '')
    {
        if (Test-Connection $s -Quiet -Count 2)
            
            {
                # Check if Zabbix Agent is installed and running, if not start the service.
                $session = New-PSSession -cn $s -Credential $cred
                Write-Host ('----------------------------------------------------------------')  
                Write-Host 'Checking if Zabbix Agent is already installed and running'

                 If (Invoke-Command -Session $session -ScriptBlock {get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Running"})
                    { Write-Host 'Service is installed and running. Nothing to do.' }

                    Elseif (Invoke-Command -Session $session -ScriptBlock {get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Stopped"}) 
                                {
                                # Starts service if it exists in a Stopped state.
                                Write-Host ('----------------------------------------------------------------')  
                                Write-Host 'Service detected but not started. Starting.'
                                Write-Host ('----------------------------------------------------------------')  
                                Start-Service "Zabbix Agent" -ErrorAction SilentlyContinue
                              
                                }
                                    
                         Else {       

            # Copy Zabbix Agent folder, Create new service, then start service.
            Write-Host ('----------------------------------------------------------------')  
            Write-Host 'Copying Zabbix agent folder using system share'
            Write-Host ('----------------------------------------------------------------')  
            Copy-Item -Recurse -Path $SourceFolder -Destination $TargetFolder -ToSession $Session -Force 
            Write-Host 'Installing agent service'
            Write-Host ('----------------------------------------------------------------')  
            Invoke-Command -Session $session -ScriptBlock { 
                                                            New-Service -Name "Zabbix Agent" -BinaryPathName '"C:\Program Files\Zabbix_agent\bin\win64\zabbix_agentd.exe" --config "C:\Program Files\Zabbix_agent\conf\zabbix_agentd.win.conf"' -DisplayName "Zabbix Agent" -Description "Provides system monitoring" -StartupType "Automatic" -ErrorAction SilentlyContinue
                                                            Write-Host 'Starting service'
                                                            Start-Service -DisplayName "Zabbix Agent" -ErrorAction SilentlyContinue}
                                                           }
                                                 
            # Lets do checks
            Write-Host ('----------------------------------------------------------------')  
            Write-Host 'Now lets dot some post-install checks'
            Write-Host ('----------------------------------------------------------------')  
            if (Invoke-Command -Session $session -ArgumentList $TargetFolder -ScriptBlock {param($TargetFolder) Test-Path $TargetFolder})
                    { Write-Host 'Agent folder is present.' }
                        else 
                            {Write-Host 'Agent folder is missing, smth went wrong during copy, please check manually'}
            If (Invoke-Command -Session $session -ScriptBlock {get-service -Name "Zabbix Agent" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Running"})
                    { Write-Host 'Service is installed and running' }
                        else 
                            {Write-Host 'Service is missing or stopped,smth went wrong during copy, please check manually'}
                            }

            else
                    {
                    Write-Host ('----------------------------------------------------------------')  
                    Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $server.ToUpper())
                    Write-Host ('----------------------------------------------------------------')
                    write-host -ForegroundColor Red ($server + ' is unreachable')
                     }
        }
     

# Lets kill all opened ps sessions just in case
Get-PSSession | Remove-PSSession    