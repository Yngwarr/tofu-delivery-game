extends VehicleBody3D

func _physics_process(_delta):
	steering = Input.get_axis("steer_right", "steer_left") * .4
	engine_force = Input.get_axis("brake", "throttle") * 100
