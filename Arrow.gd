extends CharacterBody2D

@export var damage : int
@onready var frames = $Sprite2D

var texture : Texture2D

var speed : int

func ready():
	frames.texture = texture
func _physics_process(delta):
	velocity = Vector2(speed * delta,0).rotated(rotation)
	speed *= 0.99
	#if rotation_degrees < 90:
		#rotation_degrees += 30*delta
	move_and_slide()



func _on_timer_timeout():
	queue_free()
