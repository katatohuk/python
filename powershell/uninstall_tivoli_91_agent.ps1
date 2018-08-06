$servers = Get-Content \\dk01sn008\Test\Temp\ADPK\win16_test.txt

Write-host -BackgroundColor Yellow -ForegroundColor Black 'Script will uninstall Tivoli agent v.9.1 under PDTAU account. Password will be asked once'
Write-Host -BackgroundColor Yellow -ForegroundColor Black '-----------------------------------------------------------------------------------------'
Write-Host -BackgroundColor Yellow -ForegroundColor Black ''

#Below cpommand will ask you to enter password for account PDTAU only once for the whole session
$cred = get-credential -UserName scdom\pdtau -Message "Please enter password for account PDTAU just once"

foreach($server in $servers)
{
$s = New-PSSession -ComputerName $server -Credential $cred
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('Running remotely on: ' + $server)
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('')
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('Uninstalling agent')
Write-Host ('')
Invoke-Command -Session $s -ScriptBlock {cscript C:\TwsInst\TWS\twsinst.vbs -uninst -uname pdtau}
    if(Get-Service | where Name -in "tws_cpa_ssm_agent_scdom_pdtau","tws_cpa_agent_scdom_pdtau")
        {
            Write-Host -ForegroundColor Red ('Smth went wrong, please check services manually')
            Write-Host ('')
        }
            else {
                    Write-Host -ForegroundColor Green ('Unistall was successful')
                    Write-Host ('') 
                 }
Write-Host -BackgroundColor Yellow -ForegroundColor Black ('Deleting folder C:\TwsInst')
Invoke-Command -Session $s -ScriptBlock {Remove-Item -Force -Recurse C:\TwsInst}
    if(Test-Path -Path C:\TwsInst)
        {
            Write-Host -ForegroundColor Red ('Path wasnt deleted, please check manually')
            Write-Host ('')
        }
            else {

                    Write-Host -ForegroundColor Green ('Path was deleted successfully')
                    Write-Host ('')
                 }
}
Get-PSSession | Remove-PSSession