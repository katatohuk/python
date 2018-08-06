<#
.AUTHOR
 ADPK

.NAME
 Check and sort Windows OS versions for remote servers.

.SYNOPSIS
 Gets server/servers list as input script parameter, if empty gets localhost as target machine.
 In case of server list - logs it to out txt files:
 .\scipt_working_dir\out08.txt - for Win2008
 .\scipt_working_dir\out12.txt - for Win2012
 .\scipt_working_dir\out18.txt - for Win2016

.USAGE
 check_os_version_sorted.ps     for a localhost
 check_os_version_sorted.ps -s  <SERVERNAME> ## for a single server
 check_os_version_sorted.ps -sl <PATH_TO_TEXT_FILE> ## for a list of servers in a txt file
#>


# Script params
param([Parameter(Mandatory=$false)][array]$sl,[string]$s)

# User defined variables.
$out08 = $PSScriptRoot + '\out08.txt'
$out12 = $PSScriptRoot + '\out12.txt'
$out16 = $PSScriptRoot + '\out16.txt'

# Check if files dont exist, create firstly
if(!(Test-Path $out08))
   {
   Write-Host ("`nCreating out file " + $out08)
   New-Item $out08 -ItemType File | Out-Null
   }
if(!(Test-Path $out12))
   {
   Write-Host ("`nCreating out file " + $out12)
   New-Item $out12 -ItemType File | Out-Null
   }
if(!(Test-Path $out16))
   {
   Write-Host ("`nCreating out file " + $out16)
   New-Item $out16 -ItemType File | Out-Null
   }

# Lets clear out.txt files before start
Clear-Content $out08
Clear-Content $out12
Clear-Content $out16

# Logic for -sl option
if(!$sl -eq '')
    {
     # Reading content of the txt file
     $cred = get-credential -UserName scdom\pdbaa -Message "Please enter password for account PDBAA just once"
     $sl = get-content $sl
     Write-Host ''
     Write-Host ('Checks are in progress, please be patients, all data will be logged...')
     foreach($server in $sl)
        {
            # Lets test if servers are online
            if (Test-Connection $server -Quiet -Count 2)
            
            {
             $session = New-CimSession -cn $server -Credential $cred
             $osver = Get-CimInstance Win32_OperatingSystem -CimSession $session | Select-Object CSName, Caption
                if($osver.Caption -like "*2008*")
                {Write-Output $server | Out-File -Append $out08}
                    elseif($osver.Caption -like "*2012*")
                          {Write-Output $server | Out-File -Append $out12} 
                            elseif($osver.Caption -like "*2016*")
                                  {Write-Output $server | Out-File -Append $out16}  

                            }
                else
                    {
                        write-host -ForegroundColor Red ($server + ' is unreachable')
                     }
        }

        
        Write-Host -NoNewline ("`nWindows 2008 servers list: " + $out08 + "`nServers in file:  ")
        Get-Content $out08 | Measure-Object -Line | Select-Object -ExpandProperty Lines
        Write-Host -NoNewline ("`nWindows 2012 servers list: " + $out12 + "`nServers in file: ") 
        Get-Content $out12 | Measure-Object -Line | Select-Object -ExpandProperty Lines
        Write-Host -NoNewline ("`nWindows 2016 servers list: " + $out16 +  "`nServers in file: ") 
        Get-Content $out16 | Measure-Object -Line | Select-Object -ExpandProperty Lines
         

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