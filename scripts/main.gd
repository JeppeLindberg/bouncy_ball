extends Node2D


@export var breakable_gradient: Gradient

var _seconds = 0.0

func _process(delta: float) -> void:
	_seconds += delta

func seconds():
	return _seconds

