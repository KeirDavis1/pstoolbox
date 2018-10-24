# Demo function to show how the tool can be used
# Asks user how their eggs like to be cooked

Function UnzipTool {
	$infile = Function_CreateInputBox -title "Input File" -description "Paste input file location below" -default ""
	if ($infile -eq $null) {
		Write-Debug "User cancelled input"
		return $null
	}

	$outdir = Function_CreateInputBox -title "Output Directory" -description "Paste output directory location below" -default ""
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
