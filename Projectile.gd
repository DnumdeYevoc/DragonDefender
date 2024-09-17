extends CharacterBody2D

@export var damage : int
var speed :int
@onready var animation : AnimatedSprite2D
@onready var Fireball = $animation
@onready var fire= $Fire
var is_fire = true
var size = 50
var game : Node2D
var proj_profile : Proj
func _ready():
	animation = Fireball
	
	animation.sprite_frames = proj_profile.animation
	size = proj_profile.size
	is_fire = proj_profile.is_fire 
	
	
	
	game = get_tree().get_root().get_node('Game')
func _physics_process(delta):
	animation.play()
	
	scale = Vector2((position.y + size) /300,(position.y + size)/300)
	
	velocity = Vector2(speed * delta*(position.y /200),0).rotated(rotation+ deg_to_rad(90))
	move_and_slide()
	if not game.reset:
		queue_free()

func _on_timer_timeout():
	queue_free()
