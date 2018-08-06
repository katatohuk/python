$servers = Get-Content \\dk01sn008\Test\Temp\ADPK\win16_test.txt

Write-Host ''
Write-Host -BackgroundColor Yellow -ForegroundColor Black '##' -NoNewline
Write-host ' Script will install Tivoli agent v.9.3 under PDTAU account. Password will be asked once'
Write-Host '-----------------------------------------------------------------------------------------'
Write-Host ''

#Below cpommand will ask you to enter password for account PDTAU only once for the whole session
$cred = get-credential -UserName scdom\pdtau -Message "Please enter password for account PDTAU just once"

#Copying installation script on remote server in advance
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('##') -NoNewline
Write-Host (' Lets copy installation script on remote server from network share to C:\Temp folder as PS in PSSession doenst support UNC pathes')


foreach($server in $servers)
{
$s = New-PSSession -ComputerName $server -Credential $cred
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('##') -NoNewline
Write-Host (' Creating C:\Temp\Agent folder on remote server ' + $server)
Write-Host ''
New-Item -ItemType "directory" -Path \\$server\C$\Temp\Agent -Force

Write-Host ''
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('##') -NoNewline
Write-Host (' Copying Agent installation filse from network share to remote server ' + $server)

Copy-Item -Path \\dk01snt899\Software\IBM\TWS\9.3\Agent\ -Recurse -Destination \\$server\C$\temp\ -Force

Write-Host ('')
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('##') -NoNewline
Write-Host (' Installing agent on server ' + $server)
Write-Host ('')

Invoke-Command -Session $s -ArgumentList $server -ScriptBlock { param ($server)
                                                                $env:SEE_MASK_NOZONECHECKS = 1
                                                                cd C:\Temp\Agent\WINDOWS_X86_64\
                                                                cscript C:\Temp\Agent\WINDOWS_X86_64\twsinst.vbs -new -uname pdtau -password TAUadmin1 -domain scdom -acceptlicense yes -addjruntime true -agent dynamic -company Simcorp -hostname $server'.scdom.net' -inst_dir c:\TwsInst -tdwbhostname DK01SV8871 -displayname $server'_1' -skipcheckprereq}


Copy-Item -Path \\$server\C$\TwsInst\TWS\bin\taskLauncher.cmd -Destination \\$server\C$\TwsInst\TWS\bin\taskLauncher_BACKUP.cmd -Force
Copy-Item -Path \\dk01sv1364\test\Technical\Batch\TWS\Deployment\taskLauncher93_PROD.cmd -Destination \\$server\C$\TwsInst\TWS\bin\taskLauncher.cmd -Force


    if(Get-Service -ComputerName $server | where Name -in "tws_cpa_ssm_agent_scdom_pdtau","tws_cpa_agent_scdom_pdtau")
        {
            Write-Host ''
            Write-Host -ForegroundColor Green ('Installaion was successful')
            Write-Host ('')
        }
            else {
                    Write-Host ''
                    Write-Host -ForegroundColor Red ('Smth went wrong, please check installation manually')
                    Write-Host ('')
                 }
}
Get-PSSession | Remove-PSSession









