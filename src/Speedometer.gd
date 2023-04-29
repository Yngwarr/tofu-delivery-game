extends Label

@export var car: RigidBody3D

func _physics_process(_delta):
	# converting to km/h
	var speed = car.get_linear_velocity().length() * 3.6
	text = "%.f km/h" % speed
