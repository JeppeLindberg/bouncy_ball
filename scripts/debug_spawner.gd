extends Node2D

@export var debug_spawn: PackedScene

func spawn(new_position):
	var new_node = debug_spawn.instantiate()
	add_child(new_node)
	new_node.global_position = new_position
