extends Node2D

@onready var enemy_container = $enemy_container
@onready var bg = $Background
@onready var castle = $Castle
@onready var enemy= preload('res://Enemy.tscn')
@onready var score_label = $board/Score
@onready var highscore_label = $board/highscore
var random = RandomNumberGenerator.new()
var spawn_x :int
var cooldown = 0
var spawner_countdown = 100
var waves = [[]]
var en_index = -1
var wave_index = 0
var en_amount = 2
var spawner_countdown_length = 100
var score = 0
var death_animation_cooldown = 0
@onready var highscore = load_data_from("user://highscore")
func _ready():
	score_label.text = str(score)
	highscore_label.text = 'HI:'+ str(highscore)
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
		
func enemy_death(points):
	score += points
	score_label.text =   str(score)
	if score > highscore:  
		print(highscore)
		score_label.text = ' NEW HIGHSCORE'
		highscore = score
		highscore_label.text = 'HI:'+ str(highscore)
		save_data_to("user://highscore", highscore)
func game_over():
	
	death_animation_cooldown +=1
	if death_animation_cooldown >= 100:
		if castle.position.y >= 250:
			bg.position.y +=0.4
			position.y -=1.5
			castle.position.y -=1.5
			enemy_container.scale_up(0.85)
		else:
			enemy_container.move_up(1)
	else:
		enemy_container.move_up(1)
func load_data_from(save_path : String):
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		return file.get_var()
	else:
		return 0
func save_data_to(save_path: String, data):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
