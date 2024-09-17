extends CharacterBody2D

@export var damage : int
var speed :int
@onready var animation : AnimatedSprite2D
@onready var Fireball = $Fireball
@onready var fire= $Fire
@onready var is_fire = true
var game : Node2D
func _ready():
	animation = Fireball
	game = get_tree().get_root().get_node('Game')
func _physics_process(delta):
	animation.play()
	
	scale = Vector2((position.y + 50) /300,(position.y + 50)/300)
	
	velocity = Vector2(speed * delta*(position.y /200),0).rotated(rotation+ deg_to_rad(90))
	move_and_slide()
	if not game.reset:
		queue_free()

func _on_timer_timeout():
	queue_free()
