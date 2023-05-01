extends TextureRect

@export var fork_container: Node3D

@onready var left: Sprite2D = $Left
@onready var right: Sprite2D = $Right
@onready var fwd: Sprite2D = $Fwd

func _ready():
	for c in fork_container.get_children():
		if !(c is Fork): continue
		c.car_entered.connect(appear)
		c.fork_resolved.connect(resolve)

func appear(mode: Fork.Mode):
	left.modulate = Color.WHITE
	right.modulate = Color.WHITE
	fwd.modulate = Color.WHITE

	left.visible = mode != Fork.Mode.LEFT_IS_FWD
	right.visible = mode != Fork.Mode.RIGHT_IS_FWD
	fwd.visible = mode != Fork.Mode.REGULAR

	var tween = create_tween()\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position:y", 14, .5)

func resolve(direction: Fork.Direction):
	var tween = create_tween()\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_QUAD)

	tween.tween_property(sprite_to_hide(direction), "modulate",
			Color.TRANSPARENT, .5)
	tween.tween_property(self, "position:y", -200, .5)

func sprite_to_hide(dir: Fork.Direction):
	match dir:
		Fork.Direction.FWD: return left if left.visible else right
		Fork.Direction.LEFT: return right if right.visible else fwd
		Fork.Direction.RIGHT: return left if left.visible else fwd
