extends RigidBody2D

var mouse_captured = false
var mouse_screen_pos_from = Vector2.ZERO
var shoot = true
var start_shape_radius = 1.0

@onready var arrow = get_node('arrow')
@onready var shape = get_node('shape')
@onready var debug_spawner = get_node('/root/main/debug_spawner')
@export var velocity_squisher: Node2D
@export var impact_squisher: Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			mouse_captured = true
			mouse_screen_pos_from = get_global_mouse_position()
			shoot = false
		elif event.is_released():
			shoot = true

func _ready() -> void:
	start_shape_radius = shape.shape.radius

func _process(_delta):

	shape.shape.radius = start_shape_radius * (1.0 - linear_velocity.length() / 5000.0)

	if mouse_captured:
		var mouse_screen_pos_to = get_global_mouse_position()
		var direction = (mouse_screen_pos_to - mouse_screen_pos_from).normalized()
		var distance = mouse_screen_pos_from.distance_to(mouse_screen_pos_to)
		arrow.look_at(global_position + direction)
		arrow.scale = Vector2.ONE * sqrt(distance / 100)
		arrow.visible = true

		if shoot:
			apply_impulse(direction * distance, Vector2.ZERO)

			mouse_captured = false
			shoot = false

			impact_squisher.apply_impulse(direction, distance / 1000)
	else:
		arrow.visible = false

	velocity_squisher.set_force(linear_velocity.normalized(), linear_velocity.length() / 10000.0)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var collision_point = state.get_contact_collider_position(i)
		debug_spawner.spawn(collision_point)
		var normal = (collision_point - global_position).normalized()
		impact_squisher.apply_impulse(normal, linear_velocity.length() / 2000.0)
		break
