extends Node2D

@onready var rigidbody = get_parent()

var move_direction = Vector2.LEFT


func _physics_process(_delta: float) -> void:    
    rigidbody.apply_force(move_direction * 1000.0)

