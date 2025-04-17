extends RigidBody2D

var aiming = false
var aim_input = Vector2.ZERO
var aim_vector = Vector2.ZERO
var shoot = true
var start_shape_radius = 1.0
var last_shoot_time = 0.0

@onready var arrow = get_node('arrow')
@onready var shape = get_node('shape')
@onready var debug_spawner = get_node('/root/main/debug_spawner')
@onready var main = get_node('/root/main')
@onready var power_stacks = get_node('power_stacks')

@export var velocity_squisher: Node2D
@export var impact_squisher: Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			aiming = true
			shoot = false
		elif event.is_released():
			shoot = true
	
	if event is InputEventMouseMotion:
		aim_input = event.relative

func _ready() -> void:
	start_shape_radius = shape.shape.radius
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	last_shoot_time = main.seconds()

func _process(_delta):
	_handle_controls()

	var size_of_ball_collider_affected_by_velocity_mult = 1.0/5000.0
	shape.shape.radius = start_shape_radius * clamp((1.0 - linear_velocity.length() * size_of_ball_collider_affected_by_velocity_mult), 0.3, 1.0)

	if (main.seconds() - last_shoot_time) >= 1.0 and power_stacks.get_no_of_stacks() == 0:
		power_stacks.add_stack()

	if aiming:
		aim_vector += aim_input
		aim_input = Vector2.ZERO
		var direction = aim_vector.normalized()
		var distance = clamp(aim_vector.length(), 0.0, 300.0)
		arrow.look_at(global_position + direction)
		arrow.scale = Vector2.ONE * sqrt(distance / 100)
		arrow.visible = true
		Engine.time_scale = 0.2

		if shoot:
			if distance > 50.0:
				if power_stacks.get_no_of_stacks() > 0:
					last_shoot_time = main.seconds()

				var carried_momentum = clamp(linear_velocity.normalized().dot(direction), 0.0, 1.0)
				linear_velocity = direction * linear_velocity.length() * carried_momentum
				var force_from_power_stacks = 0.25 + power_stacks.get_no_of_stacks() * 0.75
				var impulse_force_when_shoot_mult = 1.0
				apply_impulse(direction * distance * force_from_power_stacks * impulse_force_when_shoot_mult, Vector2.ZERO)


				var squisher_impulse_force_when_shoot_mult = 1.0/1000.0
				impact_squisher.apply_impulse(direction, distance * force_from_power_stacks * squisher_impulse_force_when_shoot_mult)

				power_stacks.remove_all_stacks()

			Engine.time_scale = 1.0
			aiming = false
			shoot = false
	else:
		arrow.visible = false
		aim_vector = Vector2.ZERO

	var velocity_squish_mult = 1.0/100000.0
	velocity_squisher.set_force(linear_velocity.normalized(), linear_velocity.length() * velocity_squish_mult)

func _handle_controls():	
	if Input.is_action_just_pressed("mouse_capture"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("mouse_capture_exit"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var collision_point = state.get_contact_collider_position(i)
		debug_spawner.spawn(collision_point)
		var normal = (collision_point - global_position).normalized()
		var squisher_impulse_force_when_collide_mult = 1.0/3000.0
		impact_squisher.apply_impulse(normal, linear_velocity.length() * squisher_impulse_force_when_collide_mult)

		var other_node = state.get_contact_collider_object(i)
		if other_node is Node2D and other_node.is_in_group('breakable'):
			if other_node.take_damage():
				power_stacks.add_stack()
		
