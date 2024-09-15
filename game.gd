extends Node2D

@onready var enemy_container = $enemy_container
@onready var enemy= preload('res://Enemy.tscn')
var random = RandomNumberGenerator.new()
var spawn_x :int
var cooldown = 0
var spawner_countdown = 100
var waves = [[]]
var en_index = -1
var wave_index = 0
var en_amount = 2
var spawner_countdown_length = 100
func _physics_process(delta: float) -> void:
	enemy_container.move_up(0.1)
	if Input.is_key_pressed(KEY_W):
		spawner_countdown =  spawner_countdown_length
		en_amount = wave_index + 2
		
	if spawner_countdown == spawner_countdown_length:
		cooldown = (spawner_countdown_length*0.25/en_amount) -1
	if spawner_countdown>= 0:
		spawner_countdown -=1
		cooldown-=1
		enemy_container.move_up(0.5)
		
		if cooldown <=0 and spawner_countdown >= spawner_countdown_length*0.25:
			spawn_x = random.randi_range(1,14)
			en_index +=1
			enemy_container.spawn(3,spawn_x*20, 70,enemy)
			waves[wave_index].append(enemy_container.instance)
			for wave in waves:
				for en in wave:
					en.z_index +=1
			cooldown = (spawner_countdown_length*0.75/en_amount) -1
	
	if spawner_countdown == 1:
		wave_index +=1
		waves.append([])
		
