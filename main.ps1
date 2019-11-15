#############################################
#
# PowerShell Toolbox. Simplifying functions!
#
#############################################

$toolboxItems = New-Object System.Collections.Generic.List[System.Object]

. "./gui.ps1"

# Create toolbox list
$toolboxItems = New-Object System.Collections.Generic.List[System.Object]

# Import general functions from `functions` folder (Also imports from subfolders)
Get-ChildItem ".\functions" -Recurse -Filter *.ps1 | ForEach-Object {
	# Run tool's code
	. "$($_.FullName)"
}

# Import tools from `tools` folder (Also imports from subfolders)
Get-ChildItem ".\tools" -Recurse -Filter *.ps1 | ForEach-Object {
	# Run tool's code
	. "$($_.FullName)"

	$toolboxItems.Add($toolModule)
}

Search_Tools

Render_Gui | Out-Null
