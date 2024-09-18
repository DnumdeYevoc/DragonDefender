extends Node2D

var enemy_container : Node2D
@export var instance : Area2D
@export var enemy_list = []
var game : Node2D
var random = RandomNumberGenerator.new()
var type = 0
func _ready():
	enemy_container = get_tree().get_root().get_node('Game').get_node('enemy_container')
	game = get_tree().get_root().get_node('Game')
func spawn(collision_layer,spawn_x, spawn_y,projectile):
	instance = projectile.instantiate()
	type = random.randi_range(1,game.wave_index+5)
	if type<6:
		instance.profile = load('res://Resources/Dragon.tres')
	elif type in range(6,9):
		instance.profile = load('res://Resources/Ice_drag.tres')
	elif type >= 10:
		instance.profile = load('res://Resources/electro_drag.tres')
		

	instance.collision_layer = collision_layer
	instance.global_position = Vector2(spawn_x, spawn_y)
	enemy_container.add_child.call_deferred(instance)
	enemy_list.append(instance)
	
func move_up(rate):
	if enemy_list.size()>0:
		for enemy in enemy_list:
			enemy.position.y +=rate*(enemy.position.y/300)
func scale_up(rate):
	for enemy in enemy_list:
		enemy.scale_up +=rate*(enemy.position.y/300)
