extends Node2D

var start_time = 0.0
@onready var main = get_node('/root/main')

func _ready() -> void:
    start_time = main.seconds()

func _process(_delta: float) -> void:
    var elapsed_time = main.seconds() - start_time
    if elapsed_time > 1.0:
        queue_free()
