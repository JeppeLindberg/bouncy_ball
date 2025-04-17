extends Node2D

var sequence = 0


func set_new_node_pos(node):
    var min_x = 100000.0
    var max_x = -100000.0
    var min_y = 100000.0
    var max_y = -100000.0

    for child in get_children():
        if child.global_position.x < min_x:
            min_x = child.global_position.x
        if child.global_position.x > max_x:
            max_x = child.global_position.x
        if child.global_position.y < min_y:
            min_y = child.global_position.y
        if child.global_position.y > max_y:
            max_y = child.global_position.y

    var i = 0

    var new_spawn_x = min_x
    var new_spawn_y = min_y

    while(i < sequence):
        i += 1
        new_spawn_x += 100.0
        new_spawn_y += 300.0
        if new_spawn_x > max_x:
            new_spawn_x = min_x
        if new_spawn_y > max_y:
            new_spawn_y = min_y

    node.global_position = Vector2(new_spawn_x, new_spawn_y)
    sequence += 1



