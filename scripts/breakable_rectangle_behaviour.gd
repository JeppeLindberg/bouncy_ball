extends Node2D

@onready var rigidbody = get_parent()
@onready var black_hole = get_node('/root/main/black_hole')

@export var movement_speed_mult = 1.0
@export var move_direction = Vector2.LEFT

var start_location = Vector2.ZERO
var sprite_scale = Vector2.ZERO
var shape_scale = Vector2.ZERO


func _ready() -> void:
	add_to_group('behaviour')
	start_location = global_position

func _physics_process(_delta: float) -> void:
	if sprite_scale == Vector2.ZERO:
		sprite_scale = rigidbody.sprite.scale
	if shape_scale == Vector2.ZERO:
		shape_scale = rigidbody.shape.scale

	var new_scale_mult = remap(global_position.distance_to(black_hole.global_position) / start_location.distance_to(black_hole.global_position), 0.0, 1.0, 0.2, 1.0)
	rigidbody.sprite.scale = sprite_scale * new_scale_mult
	rigidbody.shape.scale = shape_scale * new_scale_mult

	rigidbody.apply_force(move_direction * 10000.0 * movement_speed_mult)

