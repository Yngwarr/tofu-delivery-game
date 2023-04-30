extends Node3D

var amountTagged = 0

func _ready():
	for c in get_children():
		if !(c is Checkpoint): continue
		c.tagged.connect(child_tagged)

func child_tagged():
	amountTagged += 1
