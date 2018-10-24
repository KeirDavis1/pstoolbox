# Stores and retrieves data based on a key

Function Function_SaveData
{
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $key,
		[Parameter(Mandatory=$true)]
		[string] $value
	)
	if (-Not (Test-Path "config")){
		New-Item -ItemType 'directory' -Path "config" -Force | Out-Null
	}
	$value | Out-File "config/$key.blob"
}

Function Function_GetData
{
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $key
	)
	return Function_GetDataOrDefault -key $key -default $null
}


Function Function_GetDataOrDefault
{
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $key,
		[Parameter(Mandatory=$false)]
		[string] $default
	)
	if (-Not (Test-Path "config/$key.blob")){
		return $default
	}
	return Get-Content "config/$key.blob"
}
