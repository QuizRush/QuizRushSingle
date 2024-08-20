extends Node
class_name Damageable
signal  on_hit(node: Node, damage_taken : int)

func hit(damage : int):
	Global.enemy_health -= damage
	print("damaged by 10")
	emit_signal("on_hit", get_parent(),damage)

		

	
