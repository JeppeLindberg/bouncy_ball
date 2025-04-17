extends Node2D

@onready var main = get_node('/root/main')

var start_time = 0.0

func _ready():
	start_time = main.seconds()

func _process(_delta: float) -> void:
	var lifetime = 1.0
	var scale_mult = (1.0 - (main.seconds() - start_time) / lifetime)
	scale = Vector2.ONE * scale_mult
	rotation_degrees = (1.0 - scale_mult) * -30.0
	modulate = Color(1.0, 1.0, 1.0, scale_mult)
	if scale.x <= 0.0:
		queue_free()

