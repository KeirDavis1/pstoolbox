# Will attempt to unzip a file
# Parameters are `in` and `out`
# `in` = File
# `out` = Destination folder

Add-Type -AssemblyName System.IO.Compression.FileSystem

Function Function_Unzip_File
{
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $in,
		[Parameter(Mandatory=$true)]
		[string] $out
	)
	[System.IO.Compression.ZipFile]::ExtractToDirectory($in, $out) 
}