# Demo function to show how the tool can be used
# Asks user how their eggs like to be cooked

Function DemonstrationTool {
	$response = Function_CreateInputBox -title "This is a demo" -description "How do you like your eggs?" -default "fried"
	Write-Host "User likes their eggs $response"
}

$toolModule = @{
	name = "Demonstration"
	function = "DemonstrationTool"
}
