extends VehicleWheel3D

@export var smoke: GPUParticles3D

const SKID_THRESHOLD = .02

# used by Car.gd
var skidding = false

func _physics_process(_delta):
	var skid := get_skidinfo()
	skidding = skid < SKID_THRESHOLD

	smoke.emitting = skidding
