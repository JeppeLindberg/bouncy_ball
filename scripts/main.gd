extends Node2D


var _seconds = 0.0

func _process(delta: float) -> void:
	_seconds += delta

func seconds():
	return _seconds

