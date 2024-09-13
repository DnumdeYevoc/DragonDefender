extends Node2D

@onready var enemy_container = $enemy_container
@onready var enemy= preload('res://Enemy.tscn')
var random = RandomNumberGenerator.new()
var spawn_x :int
var cooldown = 25
var spawner_countdown = 100

func _physics_process(delta: float) -> void:
	
	if spawner_countdown>= 0:
		spawner_countdown -=1
		cooldown-=1
		
		if cooldown <=0:
			spawn_x = random.randi_range(1,40)
			enemy_container.spawn(3,spawn_x*10, 50,enemy)
			cooldown = 25
