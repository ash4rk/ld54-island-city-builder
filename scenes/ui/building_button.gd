extends TextureButton

export(PackedScene) var building

var cost: int = 0

func _ready():
	cost = _calculate_building_cost()
	
func _calculate_building_cost() -> int:
	var cost_idx = building._bundled.names.find("cost_coins")
	return building._bundled.variants[cost_idx]
