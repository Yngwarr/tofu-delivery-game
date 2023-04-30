class_name StopwatchLabel
extends Label

var value: int = 0
var t0: int = 0
var running = false

func start():
	running = true
	t0 = Time.get_ticks_msec()

func stop():
	running = false
	value += Time.get_ticks_msec() - t0

func reset():
	t0 = Time.get_ticks_msec()
	value = 0

func get_value():
	return value + Time.get_ticks_msec() - t0

func print_value():
	var v = get_value()
	return "%d.%02d.%03d" % [v / 60000, v / 1000 % 60, v % 1000]

func _process(_delta):
	if !running: return
	text = print_value()
