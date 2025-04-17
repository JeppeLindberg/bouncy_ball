extends Node2D

var sequence = 0

@export var distance = 1000.0
@export var spawn_angle = 10.0


func set_new_node_pos(node):
    var i = 0
    var angle = 0.0

    while(i < sequence):
        i += 1
        angle += spawn_angle

    node.global_position = global_position + Vector2.ONE.rotated(deg_to_rad(angle))*distance
    node.look_at(global_position)
    node.behaviour.move_direction = (global_position - node.global_position).normalized()
    sequence += 1



