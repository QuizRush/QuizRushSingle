extends State

func _ready():
	print("buuuuuuuuuuuuug")

func _physics_process(delta):
	if Global.dawhtsah:
		emit_signal("interrupt_state", self)
		Global.attacking.emit()
	elif !Global.hit_sig:
		emit_signal("interrupt_state", self)
		playback.travel("move")
	else:
		playback.travel("move")
