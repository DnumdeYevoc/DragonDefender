extends Area2D

@onready var projectile_emmiter = $ProjectileEmmiter
@onready var animation = $BD_animation
var health = 10

func _physics_process(delta : float):
	animation.play('default',100*delta)
	
	#projectile_emmiter.shoot(4,multishot,angle,speed,spawn_pos, damage, proj_texture)


func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4 and body.scale < Vector2(1.75,1.75):
		
		health -= body.damage 
		body.speed = 0
		
		if health == 0:
			queue_free()
