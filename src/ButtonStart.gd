extends Button

@export var next_scene: PackedScene

func _ready():
	pressed.connect(proceed)

func proceed():
	get_tree().change_scene_to_packed(next_scene)
