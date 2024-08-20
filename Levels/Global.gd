extends Node

var shooting := false
signal on_health_changed(node: Node, amount_changed: int)
signal stopped
signal attacking
var player_pos : Vector2
var enemy_damage_zone : Area2D
var enemy_damage_amount : int = 1
var player_alive : bool

var player_hit_box : Area2D
var playerBody : CharacterBody2D
var dawhtsah : bool
var hit_sig : bool
@export var enemy_health : int :
	get:
		return enemy_health
	set(value):
		emit_signal("on_health_changed", get_parent(), value - enemy_health)
		enemy_health = value
