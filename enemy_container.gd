extends Node2D

var enemy_container : Node2D

func _ready():
	enemy_container = get_tree().get_root().get_node('Game').get_node('enemy_container')
	
func spawn(collision_layer,spawn_x, spawn_y,projectile):
	var instance = projectile.instantiate()
	instance.collision_layer = collision_layer
	instance.global_position = Vector2(spawn_x, spawn_y)
	enemy_container.add_child.call_deferred(instance)
