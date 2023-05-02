class_name Fork
extends Node3D

signal car_entered(mode)
signal fork_resolved(direction)

enum Mode {REGULAR = 0, LEFT_IS_FWD = -1, RIGHT_IS_FWD = 1}
enum Direction {FWD = 0, LEFT = -1, RIGHT = 1}

@export var mode: Mode
@export var left_checkpoint_paths: Array[NodePath]
@export var right_checkpoint_paths: Array[NodePath]
@export var silent = false

var left_checkpoints: Array[Checkpoint]
var right_checkpoints: Array[Checkpoint]

@onready var start: Area3D = $Start
@onready var left: Area3D = $Left
@onready var right: Area3D = $Right

var engaged = false
var resolved = false

func _ready():
	start.body_entered.connect(car_enter)
	left.body_entered.connect(left_entered)
	right.body_entered.connect(right_entered)

	for p in left_checkpoint_paths:
		left_checkpoints.append(get_node(p))
	for p in right_checkpoint_paths:
		right_checkpoints.append(get_node(p))

func car_enter(_car: Car):
	if resolved: return
	if silent: return
	engaged = true
	car_entered.emit(mode)

func left_entered(_car: Car):
	if !engaged: return
	if resolved: return
	resolved = true

	if !silent:
		fork_resolved.emit(Direction.FWD if mode == Mode.LEFT_IS_FWD else Direction.LEFT)
	for c in right_checkpoints:
		c.disappear()

func right_entered(_car: Car):
	if !engaged: return
	if resolved: return
	resolved = true

	fork_resolved.emit(Direction.FWD if mode == Mode.RIGHT_IS_FWD else Direction.RIGHT)
	for c in left_checkpoints:
		c.disappear()
