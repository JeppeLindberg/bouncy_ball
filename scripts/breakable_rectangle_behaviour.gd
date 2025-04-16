extends Node2D

@onready var rigidbody = get_parent()

@export var movement_speed_mult = 1.0
@export var move_direction = Vector2.LEFT


func _physics_process(_delta: float) -> void:    
    rigidbody.apply_force(move_direction * 10000.0 * movement_speed_mult)

