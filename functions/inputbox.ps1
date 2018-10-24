# Start an instance of an input box for getting input data from the user

function Function_CreateInputBox {
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $description,
		[Parameter(Mandatory=$true)]
		[string] $title,
		[Parameter(Mandatory=$false)]
		[string] $default
	)

	return [Microsoft.VisualBasic.Interaction]::InputBox($description, $title, $default);
}
