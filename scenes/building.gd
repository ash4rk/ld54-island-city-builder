tool
extends Node

class_name Building

export var building_info: Resource

func _ready():
	self.add_child(building_info.mesh.instance())
	$IncomeTimer.wait_time = building_info.income_time
	$IncomeTimer.connect("timeout", self, "_emit_income")
	if building_info.particle_image:
		$IncomeParticle.mesh.material.albedo_texture = building_info.particle_image
	
func _emit_income():
	$IncomeParticle.emitting = true
