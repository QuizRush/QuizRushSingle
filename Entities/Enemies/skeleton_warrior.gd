extends CharacterBody2D

class_name Enemy

signal  on_hit(node: Node, damage_taken : int)
signal attacking
const speed = 50
signal facing_direction_changed(facing_right : bool)

@onready var attack_state : AttackState
@onready var healthbar : Healthbar
@onready var player : Player
@onready var damage_able := $Damageable
@onready var sprite :Sprite2D = $Sprite2D
@onready var animation_tree := $AnimationTree
@onready var bot_state_machine := $CharacterStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var damage_to_deal : int = 10
var is_dealing_damage := false




var is_enemy_chase : bool

func _ready():
	Global.enemy_health = 30
	animation_tree.active = true
	Global.dawhtsah = false
	
	#healthbar.init_health(Global.health)


func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	Global.enemy_damage_zone = $Sword
	Global.enemy_damage_amount = damage_to_deal
	
	if Global.player_alive:
		is_enemy_chase = true
	elif !Global.player_alive:
		is_enemy_chase = false
	
	var x_dif = Global.player_pos.x - position.x
	if abs(x_dif) <= 35:
		direction.x = 0
		_on_sword_area_entered(Area2D)
		Global.dawhtsah = true
	elif x_dif > 35:
		direction.x = 1
		Global.dawhtsah = false
	else:
		direction.x = -1
		Global.dawhtsah = false
	
	if direction.x != 0 and bot_state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	
	
	move_and_slide()
	update_animation_parameter()
	if bot_state_machine.current_state != bot_state_machine.states[2]:
		update_facing_direction()
	

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)
		
#func _set_health(value):
	#super.healthbar._set_health(value)
	#if Global.enemy_health <= 0 && is_alive:
		#playback.travel("dead")
	#healthbar.Global.enemy_health = Global.enemy_health


func update_animation_parameter():
	animation_tree.set("parameters/move/blend_position", direction.x)
   


func _on_sword_area_entered(area):
	Global.attacking.emit()
	if area == Global.player_hit_box:
		print("ahhahahhahahahhaahhaha")
		is_dealing_damage = true
		await get_tree().create_timer(1.0).timeout
		is_dealing_damage = false
