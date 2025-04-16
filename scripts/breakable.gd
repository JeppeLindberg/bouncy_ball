extends RigidBody2D

@export var health = 2

@onready var sprite = get_node('sprite')

func _ready() -> void:
    add_to_group('breakable')

func take_damage():
    health -= 1
    var old_color = sprite.self_modulate
    var new_color = old_color * Color(0.8, 0.8, 0.8, 1.0)
    sprite.self_modulate = new_color

    if health <= 0:
        queue_free()

