extends VehicleBody3D

@export_range(0, 1, 0.05) var steer_multiplyer := .4

var steering_wheels: Array[VehicleWheel3D]
var driving_wheels: Array[VehicleWheel3D]

var max_rpm := 500
var max_torque := 200

func _ready():
	# would've rather export arrays to fill in the inspector, but issue #62916
	# still persists in Godot 4.0.2
	for c in get_children():
		if !(c is VehicleWheel3D): continue
		if c.use_as_traction:
			driving_wheels.append(c)
		if c.use_as_steering:
			steering_wheels.append(c)

func _physics_process(delta):
	var throttle: float = Input.get_axis("brake", "throttle")

	for wheel in driving_wheels:
		wheel.engine_force = throttle * max_torque * (1 - wheel.get_rpm() / max_rpm)

	steering = lerp(steering,
		Input.get_axis("steer_right", "steer_left") * steer_multiplyer,
		5 * delta)
