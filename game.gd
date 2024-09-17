extends Node2D

@onready var enemy_container = $enemy_container
@onready var bg = $Background
@onready var castle = $Castle
@onready var enemy= preload('res://Enemy.tscn')
@onready var score_label = $board/Score
@onready var highscore_label = $board/highscore
@onready var bow = $Bow
@onready var button = $Castle/death_menu/try_again
@onready var play_button = $Castle/Main_menu/Play
@onready var game_over_label = $Castle/death_menu/GameOver
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
var main_menu = true
var reset = false
var started = false

@onready var highscore = load_data_from("user://highscore")

func _ready():
	score_label.text = str(score)
	highscore_label.text = 'Best : '+ str(highscore)
func _physics_process(delta: float) -> void:
	if main_menu:
		if not reset:
			print('reseting')
			score = 0
			started = false
			game_over_label.visible = false
			play_button.visible = true
			play_button.disabled = false
			button.disabled = true
			button.visible = false
			castle.position.y = 250
			bg.position.y = 94
			bow.position.y = 357
			bow.health = bow.max_health
			for en in enemy_container.enemy_list:
				en.queue_free()
			enemy_container.enemy_list.clear()
			
			reset = true
	elif not started:
		start_game()
	else:
		
		enemy_container.move_up(0.1)
		if len(waves[wave_index-1])==0 and spawner_countdown<0:
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
	score_label.text = 'Current : '  + str(score)
	if score > highscore: 
		
		score_label.text = ' New Best'
		highscore = score
		highscore_label.text = 'Best : '+ str(highscore)
		save_data_to("user://highscore", highscore)
func game_over():
	
	if castle.position.y > 250:
		bg.position.y +=0.4
		bow.position.y -=1.5
		castle.position.y -=1.5
		enemy_container.scale_up(1)
		game_over_label.visible = true
		
		button.disabled = false
		button.visible = true
		reset = false
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


func _on_button_pressed() -> void:
	main_menu = true

func _on_play_pressed() -> void:
	main_menu = false
	play_button.visible = false
	play_button.disabled = true
func start_game():
	if castle.position.y < 600 and not started:
		bg.position.y -=0.4
		bow.position.y +=2
		castle.position.y +=2
		
	else:
		
		started = true
		
