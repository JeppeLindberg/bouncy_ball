extends RigidBody2D

@export var health = 2

@onready var sprite = get_node('sprite')
@onready var shape = get_node('shape')
@onready var main = get_node('/root/main')

var behaviour : Node2D

func _ready() -> void:
	add_to_group('breakable')
	for child in get_children():
		if child.is_in_group('behaviour'):
			behaviour = child
			break
	
	sprite.self_modulate = main.breakable_gradient.sample(fmod(main.seconds() / 10.0, 1.0))

func take_damage():
	health -= 1
	var old_color = sprite.self_modulate
	var new_color = old_color * Color(0.8, 0.8, 0.8, 1.0)
	sprite.self_modulate = new_color

	if health <= 0:
		queue_free()
		return true
	else:
		return false

func consume_by_black_hole():
	queue_free()

