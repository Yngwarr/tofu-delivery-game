class_name Checkpoint
extends Area3D

signal tagged

@onready var anim: AnimationPlayer = $Anim

func _ready():
	body_entered.connect(on_car_entered)

func on_car_entered(car: Car):
	if !visible: return

	car.respawn_location = global_position + Vector3.UP
	tagged.emit()
	anim.play("disappear")
