extends TextureButton

export(Resource) var building_info

var cost: int = 0

func _ready():
	cost = building_info.cost_coins
	
