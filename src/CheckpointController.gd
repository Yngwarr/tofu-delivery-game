class_name CheckpointController
extends Node3D

signal player_finished

var amountTagged = 0

func _ready():
	for c in get_children():
		if !(c is Checkpoint): continue
		c.tagged.connect(child_tagged)

func child_tagged(finish: bool):
	amountTagged += 1
	if finish:
		player_finished.emit()
