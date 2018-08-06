<#
.NAME
 Zabbix Agent config file update though the servers.

.SYNOPSIS
 Overwrite Zabbix <zabbix_agentd.win.conf> and restart service to apply changes.
 Run it under account which is local admin on a remote server

.USAGE
 conf_update.ps -s <SERVERNAME> ## for a single server
 conf_update.ps -sl <PATH_TO_TEXT_FILE> ## for a list of servers in a txt file
#>

# Script params
param([Parameter(Mandatory=$false)][array]$sl,[string]$s)

# User defined variables.
# Change below variables with your values
$SourceFile = "\\dk01sv1364\Test\Technical\Utils\Zabbix agent_3_4_6\conf\zabbix_agentd.win.conf"
$TargetFolder = "C:\Program Files\Zabbix_agent\conf\"
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
            $session = New-PSSession -cn $server -Credential $cred
            Write-Host ('----------------------------------------------------------------')  
            Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $server.ToUpper())    
            # Copy zabbix_agentd.win.conf, then restart service to apply changes.
            Write-Host ('.')  
            Write-Host 'Copying zabbix_agentd.win.conf from network'
            Write-Host ('.')  
            Copy-Item -Path $SourceFile -Destination $TargetFolder -ToSession $Session -Force -Verbose
            Write-Host 'Restarting service'
            Write-Host ('.')  
            Invoke-Command -Session $session -ScriptBlock { 
                                                             Restart-Service -DisplayName "Zabbix Agent" -ErrorAction SilentlyContinue}
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
        # Lets test if servers is online
            if (Test-Connection $s -Quiet -Count 2)
            
            {
            $session = New-PSSession -cn $s -Credential $cred
            Write-Host ('----------------------------------------------------------------')  
            Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $s.ToUpper())    
            # Copy zabbix_agentd.win.conf, then restart service to apply changes.
            Write-Host ('.')  
            Write-Host 'Copying zabbix_agentd.win.conf from network'
            Write-Host ('.')  
            Copy-Item -Path $SourceFile -Destination $TargetFolder -ToSession $Session -Force -Verbose
            Write-Host 'Restarting service'
            Write-Host ('.')  
            Invoke-Command -Session $session -ScriptBlock { 
                                                             Restart-Service -DisplayName "Zabbix Agent" -ErrorAction SilentlyContinue}
                                                           }
                                                 
            else
                    {
                    Write-Host ('----------------------------------------------------------------')  
                    Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $s.ToUpper())
                    Write-Host ('----------------------------------------------------------------')
                    write-host -ForegroundColor Red ($s + ' is unreachable')
                     }
        }
    

# Lets kill all opened ps sessions just in case
Get-PSSession | Remove-PSSession     