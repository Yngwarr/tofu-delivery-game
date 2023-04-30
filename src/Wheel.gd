extends VehicleWheel3D

@export var smoke: GPUParticles3D

func _physics_process(_delta):
	smoke.emitting = get_skidinfo() < .3
