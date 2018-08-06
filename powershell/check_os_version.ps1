<#
.NAME
 Check OS version.

.SYNOPSIS
 Overwrite Zabbix <zabbix_agentd.win.conf> and restart service to apply changes.
 Run it under account which is local admin on a remote server

.USAGE
 check_os_version.ps    for a local server 
 check_os_version.ps -s <SERVERNAME> ## for a single server
 check_os_version.ps -sl <PATH_TO_TEXT_FILE> ## for a list of servers in a txt file
#>

# Script params
param([Parameter(Mandatory=$false)][array]$sl,[string]$s)

# User defined variables.


# Logic for -sl option
if(!$sl -eq '')
    {
     # Reading content of the txt file
     $cred = get-credential -UserName scdom\pdbaa -Message "Please enter password for account PDBAA just once"
     $sl = get-content $sl
     foreach($server in $sl)
        {
            # Lets test if servers is online
            if (Test-Connection $server -Quiet -Count 2)
            
            {
             $session = New-CimSession -cn $server -Credential $cred
             Get-CimInstance Win32_OperatingSystem -CimSession $session | Select-Object CSName, Caption 
            }
                else
                    {
                        write-host -ForegroundColor Red ($server + ' is unreachable')
                     }
        }
     }

# Logic for -s option
elseif(!$s -eq '')
    {
        $cred = get-credential -UserName scdom\pdbaa -Message "Please enter password for account PDBAA just once"
        # Lets test if servers is online
            if (Test-Connection $s -Quiet -Count 2)
            
            {
            $session = New-CimSession -cn $s -Credential $cred
            Get-CimInstance Win32_OperatingSystem -CimSession $session | Select-Object CSName, Caption
            }

                else
                    {
                        write-host -ForegroundColor Red ($s + ' is unreachable')
                     }
     }

# not input logic, will apply to localmachine
else {
        Get-CimInstance Win32_OperatingSystem | Select-Object CSName, Caption
    }


# Lets kill all opened ps sessions just in case
Get-PSSession | Remove-PSSession    