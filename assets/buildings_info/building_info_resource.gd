extends Resource

export var build_name: String = "empty"
export var cost_coins: int = 0
export var income: int = 0
export var technologies: int = 0
export var attractiveness: int = 0
export(int, FLAGS, "Coastal", "Mountains", "Ground") var required_terrain = 0

export(PackedScene) var mesh
export(Resource) var particle_image
