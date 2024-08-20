extends ProgressBar

class_name Healthbar



@onready var damage_able : Damageable
@onready var timer = $Timer
@onready var damage_bar = $DamageBar


func _set_health(new_health):
	var prev_health = Global.enemy_health
	Global.enemy_health = min(max_value , new_health)
	value =Global.enemy_health
	
	if Global.enemy_health <= 0 :
		queue_free()
	
	if Global.enemy_health  < prev_health:
		timer.start()
	else:
		damage_bar.value = Global.enemy_health


func init_health(_health):
	Global.enemy_health = _health
	max_value = Global.enemy_health
	value = Global.enemy_health
	damage_bar.max_value = Global.enemy_health
	damage_bar.value = Global.enemy_health
	
	

func _on_timer_timeout():
	damage_bar.value = Global.health
