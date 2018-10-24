# Demo function to show how the tool can be used
# Asks user how their eggs like to be cooked

Function DemonstrationTool {
	$key = 'demoquestion'
	$defaultResponse = Function_GetDataOrDefault -key $key -default 'fried'

	$response = Function_CreateInputBox -title "This is a demo" -description "How do you like your eggs?" -default $defaultResponse
	if ($response -eq $null){
		return;
	}

	Function_SaveData -key $key -value $response
	Write-Host "User likes their eggs $response"
}

$toolModule = @{
	name = "Demonstration"
	function = "DemonstrationTool"
}
