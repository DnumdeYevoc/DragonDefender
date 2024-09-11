extends CharacterBody2D

@export var damage : int
@onready var frames = $Sprite2D
var counter = 0
var texture : Texture2D
var speed : int


func ready():
	frames.texture = texture
	counter = 0
func _physics_process(delta):
	counter += 1
	velocity = Vector2(speed * delta,0).rotated(rotation)
	
	if speed>0:
		scale *= 1 -(0.001*counter)   
		speed *= 0.97
	
	if scale <= Vector2(0.01,0.01):
		speed = 0
	if speed < 400:
		speed = 0
	#if rotation_degrees < 90:
		#rotation_degrees += 30*delta
	move_and_slide()



func _on_timer_timeout():
	queue_free()
	
