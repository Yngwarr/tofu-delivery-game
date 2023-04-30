extends TextureRect

@export var car: RigidBody3D

@onready var label: Label = $Text
@onready var arrow: Sprite2D = $Arrow

func _physics_process(_delta):
	# converting to km/h
	var speed = car.get_linear_velocity().length() * 3.6
	label.text = "%.f" % speed
	arrow.rotation_degrees = 270.0 * (speed / 150)
