extends Node2D

var projectile_container : Node2D

func _ready():
	projectile_container = get_tree().get_root().get_node('Game').get_node('projectile_container')
	
func shoot(collision_layer,_multishot,angle,speed,spawn_pos,damage,projectile, proj_profile):
	var instance = projectile.instantiate()
	instance.rotation_degrees = angle
	instance.collision_layer = collision_layer
	instance.global_position = spawn_pos
	instance.damage = damage
	instance.speed = speed
	instance.proj_profile = proj_profile
	projectile_container.add_child.call_deferred(instance)
	
	
	
	
