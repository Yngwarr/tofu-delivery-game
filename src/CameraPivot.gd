extends Node3D

@export_range(1, 10, .1) var smoothness = 2.5

var direction = Vector3.FORWARD

func _physics_process(delta):
	var current_velocity: Vector3 = get_parent().get_linear_velocity()
	current_velocity.y = 0
	if current_velocity.length_squared() > 1:
		direction = lerp(direction, -current_velocity.normalized(), smoothness * delta)
	global_transform.basis = direction_to_rotation(direction)

func direction_to_rotation(look_direction: Vector3) -> Basis:
	look_direction = look_direction.normalized()
	return Basis(look_direction.cross(Vector3.UP), Vector3.UP, -look_direction)
