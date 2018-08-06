SELECT hosts.host,
		 groups.name
FROM hosts
JOIN hosts_groups ON hosts_groups.hostid = hosts.hostid
JOIN groups ON hosts_groups.groupid = groups.groupid
WHERE groups.name LIKE '%TESTCOW%' and hosts.host like '%DK01%'



