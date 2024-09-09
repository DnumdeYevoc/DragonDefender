extends CharacterBody2D

@export var damage : int
@onready var frames = $Sprite2D
var counter = 0
var texture : Texture2D

var speed : int

func ready():
	frames.texture = texture
	
func _physics_process(delta):
	counter += 1
	velocity = Vector2(speed * delta,0).rotated(rotation)
	
	if counter == 10:
		if scale > Vector2(0.5,0.5):
			scale *= 0.9/(delta/0.015)
			speed *= 0.9/(delta/0.015)
			print(delta)
		else:
			scale = Vector2(0.5,0.5)
			speed = 0
		
		counter =0

	if speed < 400:
		speed = 0
	#if rotation_degrees < 90:
		#rotation_degrees += 30*delta
	move_and_slide()



func _on_timer_timeout():
	queue_free()
