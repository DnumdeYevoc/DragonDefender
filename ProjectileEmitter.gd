extends Node2D

var projectile_container : Node2D
var projectile = preload('res://Arrow.tscn')

func _ready():
	projectile_container = get_tree().get_root().get_node('Game').get_node('projectile_container')
func shoot(collision_layer,multishot,spread,speed,spawn_pos,damage, texture):
	var instance = projectile.instantiate()
	instance.position = spawn_pos
	instance.texture = texture
	instance.damage = damage
	projectile_container.add_child.call_deferred(instance)
	
	
