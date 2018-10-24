#############################################
#
# PowerShell Toolbox. Simplifying functions!
#
#############################################

Write-Host "Initialising PS Toolbox"

# Loading VS Basic input boxes
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null

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

$selectedTool = $toolboxItems | Select-Object -Property `
	@{Label="Tool"; Expression={$_.name}}, `
	@{Label="Function"; Expression={$_.function}} `
	| Out-GridView -OutputMode Multiple -Title "Toolbox Functions"

# Check if chosen tool is null/they closed the window
if ($selectedTool -eq $null){
	Write-Debug "User cancelled program"
} else {
	Invoke-Expression "$($selectedTool.function)"
}

