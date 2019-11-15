# Demo function to show how the tool can be used
# Asks user how their eggs like to be cooked

Function DemonstrationTool($inputs) {
	Function_SaveData -key "demoToolInput" -value $inputs.eggPreference

	return "User likes their eggs $($inputs.eggPreference)"
}

$toolModule = @{
	name     = "Demonstration"
	function = "DemonstrationTool"
	inputs   = @(
		@{
			Name         = "eggPreference"
			Label        = "How do you like your eggs cooked?"
			Type         = "textbox"
			UniqueId     = "demoToolInput"
			DefaultValue = "Fried"
		}
	)
}
