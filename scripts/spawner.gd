extends Node2D

@export var rectangle_prefab: PackedScene
@export var rectangle_2_prefab: PackedScene

@onready var breakables = get_node('/root/main/breakables')

var _patterns := preload("res://scripts/library/patterns.gd").new()
var patterns = {}
var name_prefab_map = {}

var curr_pattern = 1
var curr_pattern_time = 0.0
var charge_time = 0.0

func _ready() -> void:
	patterns = _patterns.patterns
	name_prefab_map = {
		'rectangle': rectangle_prefab,
		'rectangle_2': rectangle_2_prefab,
	}

func _process(delta: float) -> void:
	charge_time += delta
	curr_pattern_time += delta

	_spawn_pattern()

func _spawn_pattern():
	if charge_time > 1.0/patterns[curr_pattern]['frequency']:
		charge_time -= 1.0/patterns[curr_pattern]['frequency']
		
		var new_node_name = patterns[curr_pattern]['objects'][0]
		var new_node = name_prefab_map[new_node_name].instantiate()
		breakables.add_child(new_node)

		var zone = get_node(patterns[curr_pattern]['zones'][0])
		zone.set_new_node_pos(new_node)
	
	if curr_pattern_time > patterns[curr_pattern]['duration']:
		curr_pattern_time -= patterns[curr_pattern]['duration']
		charge_time = 0.0
		curr_pattern += 1
		if curr_pattern > patterns.size():
			curr_pattern = 1

		
