extends Node3D

@export var checkpoint_ctl: CheckpointController
@export var music_player: AudioStreamPlayer

@export_group("Colliders")
@export var start_collider: Area3D

@export_group("UI")
@export var stopwatch_label: StopwatchLabel

func _ready():
	start_collider.body_entered.connect(start_crossed)
	checkpoint_ctl.player_finished.connect(player_finished)

func start_crossed(_car: Car):
	stopwatch_label.start()
	music_player.play()

func player_finished():
	stopwatch_label.stop()
