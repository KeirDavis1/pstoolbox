# Stores and retrieves data based on a GUID

Function Function_StoreData
{
	Param
	(
		[Parameter(Mandatory=$true)]
		[GUID] $guid,
		[Parameter(Mandatory=$true)]
		[string] $string
	)
	if (-Not (Test-Path "config")){
		New-Item -ItemType 'directory' -Path "config" -Force | Out-Null
	}
	$string | Out-File "config/$guid.blob"
}

Function Function_GetData
{
	Param
	(
		[Parameter(Mandatory=$true)]
		[GUID] $guid
	)
	if (-Not (Test-Path "config/$guid.blob")){
		return $null
	}
	return Get-Content "config/$guid.blob"
}