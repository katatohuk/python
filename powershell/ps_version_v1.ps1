###################################################################
# 
# ADPK
#
#  Usage:
# *** For a single server:
# .\ps_version_v1.ps1 -s \\servername
#
# *** For a server list from a txt file:
# .\ps_version_v1.ps1 -sl \\path_to_file_with_servers.txt
#
###################################################################



param([Parameter(Mandatory=$false)][array]$sl,[string]$s)

function Get-PSVersion {
                        param([string]$server)
                        Write-Host -NoNewline -BackgroundColor Black ($server + ' || ')
                        Write-Host -NoNewline ('PS version: ')
                        Invoke-Command -Session $session -scriptblock {$PSVersionTable.PSVersion.Major}
                        
}

$cred = get-credential -UserName scdom\pdbaa -Message "Please enter password for account PDBAA just once" 

if(!$sl -eq '')
    {
     $sl = get-content $sl
     foreach($server in $sl)
        {
         $session = New-PSSession -cn $server -Credential $cred
         get-psversion $server
            }   
    }
if(!$s -eq '')
    {
    $session = New-PSSession -cn $s -Credential $cred
    get-psversion $s
    }

