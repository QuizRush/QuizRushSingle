extends State

class_name AttackState

@export var chase_state : State

@onready var timer := $Timer

func _ready():
	timer.start()
	Global.attacking.connect(on_attack)
	

func on_attack():
	playback.travel("attack_1")
	emit_signal("interrupt_state", self)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack_1":
		if timer.is_stopped():
			next_state = chase_state
			playback.travel("move")
		else:
			playback.travel("attack_2") 
	if anim_name == "attack_2":
		next_state = chase_state
		playback.travel("move")
