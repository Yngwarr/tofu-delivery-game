class_name Car
extends VehicleBody3D

var steering_wheels: Array[VehicleWheel3D]
var driving_wheels: Array[VehicleWheel3D]
var stoplights: Array[Stoplight]

var max_rpm := 2000
var max_torque := 2000
var steer_multiplier := .5
var steer_smoothness := 5.0

func _ready():
	# would've rather export arrays to fill in the inspector, but issue #62916
	# still persists in Godot 4.0.2
	for c in get_children():
		if c is Stoplight:
			stoplights.append(c)
			continue

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
		Input.get_axis("steer_right", "steer_left") * steer_multiplier,
		steer_smoothness * delta)

	for light in stoplights:
		light.visible = throttle < 0
