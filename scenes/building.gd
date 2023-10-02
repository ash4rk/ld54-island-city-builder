tool
extends Node

class_name Building

export var building_info: Resource
onready var income_particle: CPUParticles = $IncomeParticle

func _ready():
	self.add_child(building_info.mesh.instance())
	Global.connect("collect_income", self, "_emit_income")
	if building_info.particle_image:
		income_particle.mesh.material.albedo_texture = building_info.particle_image
		income_particle.mesh.material.flags_transparent = true
		income_particle.mesh.material.flags_unshaded = true
		income_particle.mesh.size = Vector2(3.0, 3.0)
	$OnBuiltParticles.emitting = true
	
func _emit_income():
	if income_particle.emitting:
		add_child(income_particle.duplicate())
	income_particle.restart()
