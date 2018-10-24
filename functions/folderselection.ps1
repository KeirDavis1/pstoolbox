# Functionality to select a folder rather than text input

Add-Type -AssemblyName System.Windows.Forms

function Function_FolderSelection {
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $basedir,
		[Parameter(Mandatory=$true)]
		[string] $title
	)

	$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
		SelectedPath = $basedir;
		Description = $title
	}
	[void]$FolderBrowser.ShowDialog()

	return $FolderBrowser.SelectedPath
}
