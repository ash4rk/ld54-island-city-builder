extends TextureButton

export(Resource) var building_info

var cost: int = 0

func _ready():
	cost = building_info.cost_coins
	$InfoPanel/VBoxContainer/NameLabel.text = str(building_info.build_name)
	$InfoPanel/VBoxContainer/CostValueLabel.text = str(building_info.cost_coins)
	_set_sign_and_color($InfoPanel/VBoxContainer/IncomeValueLabel, building_info.income)
	_set_sign_and_color($InfoPanel/VBoxContainer/TechnologyValueLabel, building_info.technologies)
	_set_sign_and_color($InfoPanel/VBoxContainer/AttractivnessValueLabel, building_info.attractiveness)
	
	self.connect("mouse_entered", self, "_on_mouse_entered")
	self.connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	if !$InfoPanel.visible:
		$InfoPanel.show()

func _on_mouse_exited():
	if $InfoPanel.visible:
		$InfoPanel.hide()

func _set_sign_and_color(label: Label, value: int):
	var sign_char = ""
	if value > 0:
		sign_char = "+"
		label.modulate = Color.green
	elif value < 0:
		sign_char = "-"
		label.modulate = Color.red
	elif value == 0:
		sign_char = "+"
		label.modulate = Color.white
		
	label.text = sign_char+str(abs(value))
