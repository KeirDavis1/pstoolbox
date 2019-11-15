# Basic unzip tool
# Will extract an input file to an output directory

Function UnzipTool($inputs) {
	Function_SaveData -key "unzipToolFile" -value $inputs.file
	Function_SaveData -key "unzipToolOutput" -value $inputs.output

	Function_Unzip_File -in $inputs.file -out $inputs.output

	return "Success!"
}

$toolModule = @{
	name     = "Unzip File"
	function = "UnzipTool"
	inputs   = @(
		@{
			Name         = "file"
			Label        = "File to Unzip"
			Type         = "textbox"
			UniqueId     = "unzipToolFile"
			DefaultValue = "C:\Example.zip"
		},
		@{
			Name         = "output"
			Label        = "Output Location"
			Type         = "textbox"
			UniqueId     = "unzipToolOutput"
			DefaultValue = "C:\Example Output\"
		}
	)
}
