extends Button

@export var window: CanvasLayer

func _ready():
	pressed.connect(window.show)
