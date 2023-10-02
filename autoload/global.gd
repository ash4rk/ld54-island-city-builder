extends Node

const MAX_STEPS: int = 50

var coins: int = 500 setget _set_coins
var income: int = 0 setget _set_income
var technologies: int = 0 setget _set_technologies
var attractiveness: int = 0 setget _set_attractiveness
var current_step: int = 1
var history: Dictionary = {
	"income": [0], 
	"technologies": [0], 
	"attractiveness": [0]
}

signal update_stats()
signal next_move()
signal collect_income()
signal game_over()

func game_over():
	print_debug("game_over_event")
	emit_signal("game_over")

func update_stats():
	print_debug("update_stats_event")
	emit_signal("update_stats")

func next_move():
	print_debug("next_move_event")
	history.income.append(income)
	history.technologies.append(technologies)
	history.attractiveness.append(attractiveness)
	current_step += 1
	emit_signal("next_move")
	
func collect_income():
	print_debug("collect_income_event")
	self.coins += income
	emit_signal("collect_income")

func check_bankruptcy():
	if income <= 0 and coins < 0:
		game_over()

func _set_coins(new_value):
	coins = new_value
	update_stats()

func _set_income(new_value):
	income = new_value
	update_stats()

func _set_technologies(new_value):
	technologies = new_value
	update_stats()

func _set_attractiveness(new_value):
	attractiveness = new_value
	update_stats()

func reset():
	current_step = 1
	coins = 500
	income = 0
	attractiveness = 0
	technologies = 0

func game_loop():
	while current_step < MAX_STEPS:
		print("current_step ", current_step)
		print("MAX_STEPS ", MAX_STEPS)
		update_stats()
		
		yield(self, "next_move")
		collect_income()
		check_bankruptcy()
	
	game_over()

