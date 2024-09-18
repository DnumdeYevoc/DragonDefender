extends Area2D
var cooldown = 0
@onready var projectile_emmiter = $EnemyProjectileEmmiter
@onready var hitbox = $CollisionShape2D
@onready var healthbar = $healthbar
@onready var animation = $BD_animation
var random = RandomNumberGenerator.new()
var game : Node2D
var enemy_container :Node2D
var scale_up = 0


var projectile = preload('res://fireball.tscn')
var health : int
var proj_speed = 10000
var multishot = 1
var max_health = 10
var animation_speed = 100
var reload_speed = 200
var proj_damage = 10
var proj_profile

var profile : Enemy
func _ready():
	
	animation.sprite_frames = profile.animation
	proj_profile = profile.proj_profile
	health = profile.health
	multishot = profile.multishot
	proj_speed = profile.proj_speed
	proj_damage = profile.proj_damage
	max_health = profile.max_health
	animation_speed = profile.animation_speed
	reload_speed = profile.reload_speed
	enemy_container = get_tree().get_root().get_node('Game').get_node('enemy_container')
	game = get_tree().get_root().get_node('Game')
	health = max_health
	healthbar.update(0,health, max_health)
func _physics_process(delta : float):
	animation.play('default',animation_speed*delta)
	cooldown += 1
	
	scale = Vector2((position.y+scale_up) /300,(position.y + scale_up)/300)
	
	if cooldown >= random.randi_range(0.5*reload_speed,4*reload_speed):
		projectile_emmiter.shoot(2,multishot,0,proj_speed,global_position, proj_damage, projectile, proj_profile)
		cooldown = 0
	if global_position.y >= 700:
		game.game_over()
	if position.y >= 1100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 4:
		health -= body.damage 
		healthbar.update(0,health, max_health)
		
		body.queue_free()
		
		if health == 0:
			game.enemy_death(max_health)
			enemy_container.enemy_list.erase(self)
			for wave in game.waves:
				wave.erase(self)
			queue_free()
