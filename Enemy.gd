extends Area2D

@onready var projectile_emmiter = $EnemyProjectileEmmiter
@onready var animation = $BD_animation
@onready var hitbox = $CollisionShape2D
var fireball = preload('res://fireball.tscn')
var health = 10
var proj_speed = 10000
var multishot = 1
var cooldown = 0

func _physics_process(delta : float):
	animation.play('default',100*delta)
	cooldown += 1
	
	scale = Vector2(position.y /200,position.y /200)
	
	if Input.is_action_pressed('ui_up'):
		position.y += -delta*60*(position.y /200)
	if Input.is_action_pressed('ui_down') :
		position.y += delta*60*(position.y /200)
	
	if cooldown >= 200:
		projectile_emmiter.shoot(2,multishot,0,proj_speed,global_position, 1, fireball)
		cooldown = 0

func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4 and body.scale < Vector2(1.75,1.75):
		
		health -= body.damage 
		
		body.speed = 0
		body.queue_free()
		
		if health == 0:
			queue_free()
