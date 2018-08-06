<#
. Check servers avialability from the list

#>

# Change below for your purposes
$in = 'T:\Temp\ADPK\ping.txt'
$out = 'T:\temp\ADPK\out.txt'

# Lets clear out.txt file before start
Clear-Content $out

$sl = get-content $in

Write-Host ('Starting check, please be patient. All unaccessible servers will be logged.')

foreach($server in $sl)
        {
            # Lets test if servers is online
            if (Test-Connection $server -Quiet -Count 2)
            {}
            else
                    {
                    Write-host ('Server ' + $server + ' is unreachable. Writing to log file ' + $out)
                    write-output ($server) | Out-File -Append $out
                     }

        }
$count = Get-Content $out | Measure-Object -Line | Select-Object -ExpandProperty Lines
Write-Host ('Total unreachable servers count is: ' + $count)
Write-Host ('All done.')
