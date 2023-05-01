class_name Car
extends VehicleBody3D

@export var engine_sound: AudioStreamPlayer3D
@export var skid_sound: AudioStreamPlayer3D

var steering_wheels: Array[VehicleWheel3D]
var driving_wheels: Array[VehicleWheel3D]
var stoplights: Array[Stoplight]

var max_rpm := 2000
var max_torque := 2000
var steer_multiplier := .5
var steer_smoothness := 5.0

var respawn_location: Vector3
var resetting = false

func _ready():
	add_to_group('player')
	respawn_location = global_position

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

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		global_position = respawn_location
		global_rotation = Vector3.ZERO
		resetting = true

func _integrate_forces(_state):
	if !resetting: return

	resetting = false
	linear_velocity = Vector3.ZERO

func _physics_process(delta):
	var throttle: float = Input.get_axis("brake", "throttle")

	for wheel in driving_wheels:
		wheel.engine_force = throttle * max_torque * (1 - wheel.get_rpm() / max_rpm)

	steering = lerp(steering,
		Input.get_axis("steer_right", "steer_left") * steer_multiplier,
		steer_smoothness * delta)

	for light in stoplights:
		light.visible = throttle < 0

	engine_sound.pitch_scale = absf(linear_velocity.length_squared() / 1600) * 3 + 1

	var skidding := is_skidding()
	if skidding and !skid_sound.playing:
		skid_sound.play()
	if !skidding and skid_sound.playing:
		skid_sound.stop()

func is_skidding() -> bool:
	for wheel in driving_wheels:
		if wheel.skidding:
			return true
	for wheel in steering_wheels:
		if wheel.skidding:
			return true
	return false
