extends Node2D

@export var layer_prefab: PackedScene


func _ready():
	while get_child_count() < 100:
		var new_node = layer_prefab.instantiate()
		new_node.index = get_child_count()
		add_child(new_node)
		new_node.global_position = global_position
		new_node.scale = Vector2.ONE * (1.0 + new_node.index*0.5)
