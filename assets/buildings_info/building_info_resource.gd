extends Resource

export var build_name: String = "empty"
export var cost_coins: int = 0
export var income_time: float = 3.0
export(int, FLAGS, "Coastal", "OnTheRocks", "OnTheSand", "Forest") var required_terrain = 0

export(PackedScene) var mesh
export(Resource) var particle_image
