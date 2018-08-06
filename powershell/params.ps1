param ([Parameter(Mandatory=$false)]
       [String]$s, 
       [Parameter(Mandatory=$false)]
       [string]$sl)

if($s)
     {foreach($server in $s)
        {
            if(Get-Service -ComputerName $server | where Name -in "tws_cpa_ssm_agent_scdom_pdtau","tws_cpa_agent_scdom_pdtau")
                {
                Write-Host ''
                Write-Host -ForegroundColor Green ($server + ' Installaion was successful')
                Write-Host ('')
        }
            
}
    }

elseif($sl)
    {$list = Get-Content $sl
       foreach($server in $list)
{
    if(Get-Service -ComputerName $server | where Name -in "tws_cpa_ssm_agent_scdom_pdtau","tws_cpa_agent_scdom_pdtau")
        {
            Write-Host ''
            Write-Host -ForegroundColor Green ($server + ' Installaion was successful')
            Write-Host ('')
        }
}
            }