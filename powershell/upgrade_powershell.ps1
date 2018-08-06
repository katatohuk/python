<#
.AUTHOR
 ADPK

.NAME
 

.SYNOPSIS
 

.USAGE
 Run powershell console only under pdbaa account (run-as)
#>


# Script params
param([Parameter(Mandatory=$false)][array]$sl,[string]$s)


# User defined variables.
# Change below variables with your values
$Source = "\\dk01sv1364\Test\Temp\ADPK\PS\win2008\cabs\"


# Logic for -sl option
if(!$sl -eq '')
    {
     # Reading content of the txt file
     $sl = get-content $sl
     Write-Host ''
     Write-Host ('Checks are in progress, please be patients, all data will be logged...')
     foreach($server in $sl)
        {
            # Lets test if servers are online
            if (Test-Connection $server -Quiet -Count 2)
            
            {
             cp -Recurse -Path $Source -Destination \\$server\c$\temp
             $session = New-PSSession -cn $server
             Invoke-Command -Session $session -ScriptBlock {DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2809215-x64.cab /quiet /norestart
                                                            DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2872035-x64.cab /quiet /norestart
                                                            DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2872047-x64.cab /quiet /norestart
                                                            DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2819745-x64.cab /quiet /norestart
                                                               }
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
        
        # Lets test if servers is online
            if (Test-Connection $s -Quiet -Count 2)
            
            {
            cp -Recurse -Path $Source -Destination \\$s\c$\temp
            $session = New-PSSession -cn $s
            Invoke-Command -Session $session -ScriptBlock {DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2809215-x64.cab /quiet /norestart
                                                           DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2872035-x64.cab /quiet /norestart
                                                           DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2872047-x64.cab /quiet /norestart
                                                           DISM.exe /Online /Add-Package /PackagePath:C:\temp\Windows6.1-KB2819745-x64.cab /quiet /norestart
                                                               }
            }

                else
                    {
                        write-host -ForegroundColor Red ($s + ' is unreachable')
                     }
     }


# Lets kill all opened ps sessions just in case
Get-PSSession | Remove-PSSession    