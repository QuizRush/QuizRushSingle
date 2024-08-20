extends CharacterBody2D

class_name Player

@export var speed := 200.0

@onready var sprite :Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

signal facing_direction_changed(facing_right : bool)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := Vector2.ZERO
var can_take_damage : bool
var dead: bool = false
var damage_to_deal = 20
var is_dealing_damage : bool = false
var player : CharacterBody2D
var player_in_area = false
var health : int = 3000




func _ready():
	Global.player_alive = true
	animation_tree.active = true

func _physics_process(delta):
	Global.player_hit_box = $PlayerHitBox
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
			
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Control whether to move or not to move
	if direction.x != 0 and state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		dead = true
	

	move_and_slide()
	update_animation_parameter()
	update_facing_direction()
	check_hitbox()
	
func check_hitbox():
	var hitbox_areas = $PlayerHitBox.get_overlapping_areas()
	var damage : int
	if hitbox_areas:
		var hitbox = hitbox_areas.front()
		if hitbox.get_parent() is Enemy:
			damage = Global.enemy_damage_amount 
	if can_take_damage:
		take_damage(damage)
		
		
func take_damage(damage):
	if damage != 0:
		if health > 0:
			health -= damage
			print("player_health: " , health)
			if health <= 0:
				health = 0
				dead = true
				Global.player_alive = false
			take_damage_cooldown()
#
func take_damage_cooldown():
	print("huuuuuuyeeeeeee")
	can_take_damage = true
	await get_tree().create_timer(1.0).timeout
	can_take_damage = false
	

func update_animation_parameter():
	animation_tree.set("parameters/move/blend_position", direction.x)
	

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)





