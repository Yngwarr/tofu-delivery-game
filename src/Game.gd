extends Node3D

@export var checkpoint_ctl: CheckpointController

@export_group("Colliders")
@export var start_collider: Area3D

@export_group("UI")
@export var stopwatch_label: StopwatchLabel

func _ready():
	start_collider.body_entered.connect(start_stopwatch)
	checkpoint_ctl.player_finished.connect(player_finished)

func start_stopwatch(_car: Car):
	stopwatch_label.start()

func player_finished():
	stopwatch_label.stop()
