extends Area2D

@onready var projectile_emmiter = $EnemyProjectileEmmiter
@onready var animation = $BD_animation
@onready var hitbox = $CollisionShape2D
@onready var healthbar = $healthbar
var random = RandomNumberGenerator.new()
var fireball = preload('res://fireball.tscn')
var health = 20
var proj_speed = 10000
var multishot = 1
var cooldown = 0
var max_health = 10
func _ready():
	healthbar.update(0,health, max_health)
func _physics_process(delta : float):
	animation.play('default',100*delta)
	cooldown += 1
	
	scale = Vector2(position.y /300,position.y /300)
	
	if Input.is_action_pressed('ui_up'):
		position.y += -delta*60*(position.y /300)
	if Input.is_action_pressed('ui_down') :
		position.y += delta*60*(position.y /300)
	
	if cooldown >= random.randi_range(200,800):
		projectile_emmiter.shoot(2,multishot,0,proj_speed,global_position, 15, fireball)
		cooldown = 0
		
	#if game.spawner_cooldown>0:
		#position.y +=1

func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4:
		print(body.damage)
		health -= body.damage 
		healthbar.update(0,health, max_health)
		
		body.queue_free()
		
		if health == 0:
			queue_free()
