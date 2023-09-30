tool
extends Node

class_name Building

export var build_name: String = "empty"
export var cost_logs: int = 0
export var cost_rocks: int = 0
export var cost_coins: int = 0
export var income_time: float = 3.0
export(int, FLAGS, "Coastal", "OnTheRocks", "OnTheSand", "Forest") var required_terrain = 0

export(PackedScene) var mesh
export(Resource) var particle_image

func _ready():
	self.add_child(mesh.instance())
	$IncomeTimer.wait_time = income_time
	$IncomeTimer.connect("timeout", self, "_emit_income")
	if particle_image:
		$IncomeParticle.mesh.material.albedo_texture = particle_image
	
func _emit_income():
	$IncomeParticle.emitting = true
