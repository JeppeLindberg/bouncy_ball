extends Node2D

@export var stack_prefab: PackedScene


func get_no_of_stacks():
	return get_child_count()

func add_stack():
	if get_no_of_stacks() > 100:
		return

	var new_node = stack_prefab.instantiate()
	new_node.index = get_no_of_stacks()
	add_child(new_node)
	new_node.global_position = global_position
	new_node.scale = Vector2.ONE * (1.0 + new_node.index*0.5)

func remove_all_stacks():
	for child in get_children():
		child.queue_free()
