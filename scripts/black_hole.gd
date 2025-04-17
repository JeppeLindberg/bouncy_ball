extends Area2D

@export var consume_prefab: PackedScene

@onready var consumer = get_node('consumer')

func _on_body_entered(body:Node2D) -> void:
	body.consume_by_black_hole()

func consume_sprite(sprite: Node2D):
	var new_node = consume_prefab.instantiate()
	consumer.add_child(new_node)
	new_node.position = Vector2.ZERO
	sprite.reparent(new_node)
	
