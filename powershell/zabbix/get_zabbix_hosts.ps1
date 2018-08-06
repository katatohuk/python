<#
    .ADPK

    .Get all TESTCOW monitored hosts from Zabbix database and export to csv file
    
    .In order to use below please first install Mysql Connector https://dev.mysql.com/downloads/connector/net/8.0.html

#>

# Set out file to store data
$out = $PSScriptRoot + '\zabbix_servers.csv'

# Check if files dont exist, create firstly, otherwise error will be thrown
if(!(Test-Path $out))
   {
   Write-Host ("`nCreating out file " + $out8) 
   New-Item $out -ItemType File | Out-Null
   }

# Lets firstly clean up the out file if exists
Clear-Content $out

# Mysql connection and query below
$MySQLAdminUserName = 'zabbix'
$MySQLAdminPassword = ''
$MySQLDatabase = 'zabbix'
$MySQLHost = 'dk01su0063'
$ConnectionString = "server=" + $MySQLHost + ";port=3306;uid=" + $MySQLAdminUserName + ";pwd=" + $MySQLAdminPassword + ";database="+$MySQLDatabase + ";sslmode=none"

$query = "SELECT hosts.host,
		  groups.name
            FROM hosts
            JOIN hosts_groups ON hosts_groups.hostid = hosts.hostid
            JOIN groups ON hosts_groups.groupid = groups.groupid
            WHERE groups.name LIKE '%TESTCOW%' and hosts.host like '%DK01%'"


[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$Connection.ConnectionString = $ConnectionString
$Connection.Open()
$Command = New-Object MySql.Data.MySqlClient.MySqlCommand($query, $Connection)
$DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
$DataSet = New-Object System.Data.DataSet
$RecordCount = $dataAdapter.Fill($dataSet, "data")
$DataSet.Tables[0] | Export-Csv -Path $out –NoTypeInformation
$Connection.Close()

# Lets run csv in Excel at once
Invoke-Item $out 
 