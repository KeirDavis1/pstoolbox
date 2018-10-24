# Basic unzip tool
# Will extract an input file to an output directory

Function UnzipTool {
	$infile = Function_CreateInputBox -title "Input File" -description "Paste input file location below" -default ""
	if ($infile -eq $null) {
		Write-Debug "User cancelled input"
		return $null
	}

	$outdir = Function_FolderSelection -title "Output Directory" -basedir "C:/"
	if ($outdir -eq $null) {
		Write-Debug "User cancelled input"
		return $null
	}

	Function_Unzip_File -in $infile -out $outdir
}

$toolModule = @{
	name = "Unzip File"
	function = "UnzipTool"
}
