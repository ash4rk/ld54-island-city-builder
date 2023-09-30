extends Node

const MAX_STEPS: int = 50

var coins: int = 50 setget _set_coins;
var current_step: int = 0

signal update_stats()
signal next_move()
signal game_over()

func game_over():
	print_debug("game_over_event")
	emit_signal("game_over")

func update_stats():
	print_debug("update_stats_event")
	emit_signal("update_stats")

func next_move():
	print_debug("next_move_event")
	current_step += 1
	emit_signal("next_move")

func _set_coins(new_value):
	coins = new_value
	update_stats()

func game_loop():
	while current_step < MAX_STEPS:
		print("current_step ", current_step)
		print("MAX_STEPS ", MAX_STEPS)
		update_stats()
		
		yield(self, "next_move")
	
	game_over()

