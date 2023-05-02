class_name CheckpointController
extends Node3D

signal player_finished

@export var score_label: Label

const FORMAT = "%d tofu delivered"

var amountTagged = 0

func _ready():
	score_label.text = FORMAT % amountTagged
	for c in get_children():
		if !(c is Checkpoint): continue
		c.tagged.connect(child_tagged)

func child_tagged(finish: bool):
	amountTagged += 1

	score_label.text = FORMAT % amountTagged

	if finish:
		player_finished.emit()
