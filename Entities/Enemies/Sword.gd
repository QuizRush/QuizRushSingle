extends Area2D

class_name Enemy_sword

@export var enemy : Enemy

@onready var DamageBox := $CollisionShape2D

func _ready():
	monitoring = false
	enemy.connect("facing_direction_changed" , _on_enemy_facing_direction_changed)
	
func _on_body_entered(body):
	print(body.name)
	
func _on_enemy_facing_direction_changed(facing_right : bool):
	if facing_right:
		DamageBox.position = DamageBox.facing_right
	else:
		DamageBox.position = DamageBox.facing_left

	
