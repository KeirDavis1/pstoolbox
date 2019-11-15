Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


$Form = New-Object system.Windows.Forms.Form

$SearchPanel = New-Object system.Windows.Forms.Panel
$SearchInput = New-Object system.Windows.Forms.TextBox
$ToolListView = New-Object system.Windows.Forms.ListBox
$SearchLabel = New-Object System.Windows.Forms.Label

$ToolPanel = New-Object system.Windows.Forms.Panel

$currentToolValues = @{ }
$CurrentFunction = ""

$ResultLabel = New-Object System.Windows.Forms.Label

Function Apply_Model_Values($x, $y) {
	$currentToolValues[$x] = $y
}

Function Search_Tools($search = "") {
	[void] $ToolListView.Items.Clear()
	$toolboxItems | ForEach-Object {

		if ($_.name -Match $search) {
			[void] $ToolListView.Items.Add($_.name)
		}
	}
}

Function Render_Search() {
	$SearchLabel.Location = New-Object System.Drawing.Point(10, 20)
	$SearchLabel.Size = New-Object System.Drawing.Size(50, 20)
	$SearchLabel.Text = 'Search:'

	$ToolListView.text = "List Box"
	$ToolListView.width = 200
	$ToolListView.height = 335
	$ToolListView.location = New-Object System.Drawing.Point(10, 60)
	$ToolListView.Add_SelectedValueChanged( {
			Render_Tool $($this.SelectedItem)
		})

	$SearchInput.multiline = $false
	$SearchInput.width = 100
	$SearchInput.height = 20
	$SearchInput.location = New-Object System.Drawing.Point(60, 15)
	$SearchInput.Font = 'Microsoft Sans Serif,10'
	$SearchInput.Add_TextChanged( { Search_Tools $this.Text $_ })

	return @($SearchInput, $SearchLabel, $ToolListView)
}

Function Render_Tool($toolName) {
	$toolInputs = $null
	$toolboxItems | ForEach-Object {
		if ($_.name -ne $toolName) {
			return
		}
		$toolInputs = $_
	}

	$offsetPixels = 20
	$ToolPanel.controls.Clear()
	$toolInputs.inputs | ForEach-Object {
		$TempLabel = New-Object System.Windows.Forms.Label
		$TempLabel.Location = New-Object System.Drawing.Point(10, $offsetPixels)
		$Height = 20
		$TempLabel.Size = New-Object System.Drawing.Size(400, $Height)
		$offsetPixels = $offsetPixels + $Height + 10
		$TempLabel.Text = $_.Label
		$ToolPanel.controls.Add($TempLabel)

		if (
			$_.Type -eq "textarea" -or
			$_.Type -eq "textbox"
		) {
			Apply_Model_Values $($_.Name) $($_.DefaultValue)
			$TempInput = New-Object system.Windows.Forms.TextBox
			$TempInput.multiline = $false
			$TempInput.width = 400
			$TempInput.AcceptsReturn = ($_.Type -eq "textarea")
			$TempInput.AcceptsTab = $True
			$TempInput.multiline = ($_.Type -eq "textarea")
			$TempInput.ScrollBars = 'Both'
			$TempInput.height = 100
			$TempInput.Name = $_.Name
			$TempInput.Text = Function_GetDataOrDefault -key $($_.UniqueId) -default $($_.DefaultValue)
			$TempInput.location = New-Object System.Drawing.Point(10, $offsetPixels)
			$offsetPixels = $offsetPixels + $TempInput.height + 10
			$TempInput.Font = 'Microsoft Sans Serif,10'
			$TempInput.Add_TextChanged( {
					Apply_Model_Values $($this.Name) $($this.Text)
				})
			$ToolPanel.controls.Add($TempInput)
		}
		if (
			$_.Type -eq "list"
		) {
			$TempList = New-Object system.Windows.Forms.ListBox
			$TempList.text = "List Box"
			$TempList.Name = $_.Name
			$TempList.width = 400
			$TempList.height = 100
			$TempList.location = New-Object System.Drawing.Point(10, $offsetPixels)
			$offsetPixels = $offsetPixels + $TempList.height + 10

			$_.Options.Split($_.Separator) | ForEach-Object {
				$TempList.Items.Add($_)
			}

			$TempList.SelectedItem = Function_GetDataOrDefault -key $($_.UniqueId) -default $($_.DefaultValue)

			$TempList.Add_SelectedValueChanged( {
					Apply_Model_Values $($this.Name) $($this.SelectedItem)
				})

			$ToolPanel.controls.Add($TempList)
		}
	}

	$ExecuteButton = New-Object system.Windows.Forms.Button
	$ExecuteButton.text = "Execute"
	$ExecuteButton.width = 100
	$ExecuteButton.height = 30
	$ExecuteButton.location = New-Object System.Drawing.Point(10, $offsetPixels)
	$ExecuteButton.Font = 'Microsoft Sans Serif,10'

	$global:CurrentFunction = $toolInputs.function

	$ExecuteButton.Add_Click( {
			$this.Enabled = $False
			$ResultLabel.Text = Invoke-Expression "$global:CurrentFunction `$currentToolValues"
			$this.Enabled = $True
		})

	$offsetPixels = $offsetPixels + $ExecuteButton.height + 10
	$ToolPanel.controls.Add($ExecuteButton)


	$ResultLabel.Location = New-Object System.Drawing.Point(10, $offsetPixels)
	$ResultLabel.Size = New-Object System.Drawing.Size(400, $Height)
	$offsetPixels = $offsetPixels + $Height + 10

	$offsetPixels = $offsetPixels + $ResultLabel.height + 10

	$ToolPanel.controls.Add($ResultLabel)
}

Function Render_Gui() {
	$Form.ClientSize = '800,400'
	$Form.text = "PS Toolbox"
	$Form.TopMost = $false

	$controls = Render_Search

	$Form.controls.AddRange($controls)
	$ToolPanel.Height = 400;
	$ToolPanel.Width = 540;
	$ToolPanel.Location = New-Object System.Drawing.Point(250, 0)

	$Form.controls.Add($ToolPanel)
	$Form.TopMost = $True;
	$Form.ShowDialog()

	return $Form;
}
