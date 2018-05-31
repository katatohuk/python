<#	
		.NOTES
		===========================================================================
		 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.124
		 Created on:   	7/28/2016 13:29
		 Created by:   	Colin Squier <hexalon@gmail.com
		 Filename:     	Enable-AutomaticManagedPageFile.ps1
		===========================================================================
		.DESCRIPTION
			Enables the automatic managed page file for all drives.
	#>

	[CmdletBinding()]
	Param ()

	#Configure page file
	$PageFileInfo = Get-WmiObject -Class Win32_ComputerSystem -EnableAllPrivileges
	$PageFile = $PageFileInfo.AutomaticManagedPageFile
	if ($PageFile -eq $false)
	{
		Write-Verbose -Message "The system is currently not using an automatically managed page file. Enabling."
		$PageFileInfo.AutomaticManagedPageFile = $true
		[Void]$PageFileInfo.Put()
	}
	else
	{
		Write-Verbose -Message "The system is currently using an automatically managed page file."
	}