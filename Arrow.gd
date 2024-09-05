extends CharacterBody2D

@export var damage : int
@onready var frames = $Sprite2D

var texture : Texture2D

var speed : int

func ready():
	frames.texture = texture
func _physics_process(delta):
	velocity.x = speed * delta
	move_and_slide()



func _on_timer_timeout():
	queue_free()
