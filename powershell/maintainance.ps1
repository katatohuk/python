###################################################################
# Purpose: Check disk D: and Tivoli agent status (running/linked) 
#
# ADPK
#
# Usage:
# *** For a single server:
# .\maintainance.ps1 -s servername
#
# *** For a server list from a txt file:
# .\maintainance.ps1 -sl path_to_file_with_servers.txt
#
###################################################################



param([Parameter(Mandatory=$false)][array]$sl,[string]$s)

$ErrorLog = '.\error.log'
$DateStamp = get-date -uformat "%Y-%m-%d %H:%M:%S"

function Get-Disk {[cmdletbinding()]
               param ([string]$drive) 
               $check = Invoke-Command -Session $session -ArgumentList $drive -ScriptBlock {param ($drive) Get-WmiObject Win32_logicaldisk | select -Property DeviceId, @{Name='GB'; Expression={[math]::round($_.size/1GB, 2)}} | where -Property DeviceId -eq $drive } 
               $check  
                       }

function Get-Tivoli {param([string]$server)


Add-Type -Path “C:\Oracle12c\Oracle12cClient\ODP.NET\managed\common\Oracle.ManagedDataAccess.dll"
$connection = New-Object Oracle.ManagedDataAccess.Client.OracleConnection("User Id=IWSPROD;Password=IWSPROD;Data Source=DK01SU0803/U0303201")
$cmd1 = $connection.CreateCommand()
$cmd2 = $connection.CreateCommand()
$query1 = "SELECT PWKS_NAME FROM PWKS_WORKSTATIONS where PWKS_JOBMAN_UP='N' and PWKS_NAME like '%$server%'"
$query2 = "SELECT PWKS_NAME FROM PWKS_WORKSTATIONS where PWKS_LINK_STATUS='N' and PWKS_NAME like '%$server%'"

$cmd1.CommandText = $query1 
$cmd2.CommandText = $query2
$connection.Open()

$rdr1 = $cmd1.ExecuteReader()
if ($rdr1.Read()) {
    
    $out1 = $rdr1.GetString(0)
    Write-host -NoNewline ('Agent is running: ')
    Write-host -ForegroundColor Red -NoNewline ('NO ')
    Write-Host $out1
        
}
    else{
         Write-host -NoNewline ('Agent is running: ')
         Write-Host -ForegroundColor Green -NoNewline  ('YES ')
         Write-Host $out1
    }

$rdr2 = $cmd2.ExecuteReader()
if ($rdr2.Read()) {
    
    $out2 = $rdr2.GetString(0)
    Write-host -NoNewline ('Agent is linked: ')
    Write-host -ForegroundColor Red -NoNewline  ('NO ')
    Write-Host $out2
      
}
    else {
          Write-host -NoNewline ('Agent is linked: ')
          Write-Host -ForegroundColor Green -NoNewline  ('YES')
          Write-Host $out2
          }

$connection.Close()

}


$cred = get-credential -UserName scdom\pdbaa -Message "Please enter password for account PDBAA just once" 

if(!$sl -eq '')
    {
     $sl = get-content $sl
     foreach($server in $sl)
        {
            if (Test-Connection $server -Quiet -Count 2)
            
        {
         Write-Host ('----------------------------------------------------------------')  
         Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $server.ToUpper())
         Write-Host ('----------------------------------------------------------------')
         Write-Host -ForegroundColor darkYellow ('# Checking drive D:\ status')
         $session = New-PSSession -cn $server -Credential $cred
         $check_d = get-disk D:
            if($check_d.GB -gt 14)
        {
            Write-Host ('Size: ' + $check_d.GB)
            Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is ')
            Write-host -ForegroundColor Green ('OK')
        }
            else {Write-output -NoNewline ('Drive ' + $check_d.DeviceID + ' is') | Out-File $ErrorLog -Append
                  Write-output -ForegroundColor Red ( ' NOT ok') | Out-File $ErrorLog -Append
                  Write-output ('Disk is misssing or size doesnt match') | Out-File $ErrorLog -Append
                  Write-output ('Size: ')$check_d.GB | Out-File $ErrorLog -Append
                                    }
         Write-Host ('')
         Write-Host ('----------------------------------------------------------------')  
         Write-Host -ForegroundColor darkYellow ('Checking Tivoli agent is linked and running')
         Get-Tivoli $server
            } 
                else {
                    Write-Host ('----------------------------------------------------------------')  
                    Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $server.ToUpper())
                    Write-Host ('----------------------------------------------------------------')
                    write-host -ForegroundColor Red ($server + ' is unreachable')
                     }  
                }
                    
    }
            
if(!$s -eq '')
    {
        
            if (Test-Connection $s -Quiet -Count 2) {
    Write-Host ('----------------------------------------------------------------')  
    Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $s.ToUpper())
    Write-Host ('----------------------------------------------------------------')
    $session = New-PSSession -cn $s -Credential $cred
    $check_d = get-disk D:
        if($check_d.GB -gt 14)
        {
            Write-Host ('Size: ' + $check_d.GB)
            Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is ')
            Write-host -ForegroundColor Green ('OK')
        }
            else {Write-Host -NoNewline ('Drive ' + $check_d.DeviceID + ' is')
                  Write-host -ForegroundColor Red ( ' NOT ok')
                  Write-Host ('Disk is misssing or size doesnt match')
                  Write-host ('Size: ')$check_d.GB
                                    }
     Write-Host ('')
     Write-Host ('----------------------------------------------------------------')  
     Write-Host -ForegroundColor darkYellow ('Checking Tivoli agent is linked and running')
     Get-Tivoli $s
                     }
             else {
                    Write-Host ('----------------------------------------------------------------')  
                    Write-Host -BackgroundColor Black -ForegroundColor DarkCyan ('## ' + $s.ToUpper())
                    Write-Host ('----------------------------------------------------------------')
                    write-host -ForegroundColor Red ($s + ' is unreachable')
                     }        
    }

