extends Area2D



func _on_body_entered(body:Node2D) -> void:
	body.consume_by_black_hole()
