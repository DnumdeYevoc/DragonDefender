extends CharacterBody2D

@export var damage : int
var speed :int
@onready var animation = $Fireball
@onready var fire = $Fire

func _physics_process(delta):
	animation.play()
	
	scale = Vector2((position.y + 100) /200,(position.y + 100)/200)
	
	velocity = Vector2(speed * delta*(position.y /200),0).rotated(rotation+ deg_to_rad(90))
	move_and_slide()

func _on_timer_timeout():
	queue_free()
