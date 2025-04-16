extends Node2D

@export var rectangle_prefab: PackedScene

@onready var breakables = get_node('/root/main/breakables')

var _patterns := preload("res://scripts/library/patterns.gd").new()
var patterns = {}
var name_prefab_map = {}

var curr_pattern = 1
var charge_time = 0.0

func _ready() -> void:
	patterns = _patterns.patterns
	name_prefab_map = {
		'rectangle': rectangle_prefab
	}

func _process(delta: float) -> void:
	charge_time += delta

	if curr_pattern == 1:
		_pattern_1()

func _pattern_1():
	if charge_time > 1.0/patterns[1]['frequency']:
		charge_time -= 1.0/patterns[1]['frequency']
		
		var new_node_name = patterns[1]['objects'][0]
		var new_node = name_prefab_map[new_node_name].instantiate()
		breakables.add_child(new_node)

		var zone = get_node(patterns[1]['zones'][0])
		zone.set_new_node_pos(new_node)

		
