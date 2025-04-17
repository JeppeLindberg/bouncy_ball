extends Node2D

var spring_rigidness = 0.05
var spring_damping = 0.1
var spring_velocity = 0.0
var spring_destination = 1.0
var up_direction = Vector2.UP

@onready var pivot = get_node('pivot')

func apply_impulse(normal, force):
	up_direction = normal
	look_at(global_position + up_direction)
	rotation_degrees += 90.0
	pivot.rotation = -rotation
	scale.x *= 1.0 + sqrt(force)
	scale.x = max(0.1, scale.x)
	scale.y = max(0.1, 2.0 - scale.x)

func set_force(direction, force):
	up_direction = direction
	look_at(global_position + up_direction)
	pivot.rotation = -rotation

	spring_destination = 1.0 + sqrt(force)

func _process(delta: float) -> void:
	spring(delta)


func spring(delta) -> void:
	var distance_to_destination = scale.x - spring_destination
	var loss = spring_damping * spring_velocity * delta * 100.0

	var force = -spring_rigidness * distance_to_destination - loss
	spring_velocity += force
	scale.x += spring_velocity
	scale.x = max(0.1, scale.x)
	scale.y = max(0.1, 2.0 - scale.x)


