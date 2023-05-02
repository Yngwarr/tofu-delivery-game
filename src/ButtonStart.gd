extends Button

@export var next_scene: PackedScene
@export var next_scene_name: String

func _ready():
	pressed.connect(proceed)

func proceed():
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		get_tree().change_scene_to_file(next_scene_name)
