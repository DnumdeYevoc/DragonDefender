extends CharacterBody2D

var speed = 200

func _ready():
	pass
func _physics_process(delta: float):
	velocity.y = 0
	if Input.is_action_pressed('ui_up'):
		velocity.y = -speed*delta*60
	if Input.is_action_pressed('ui_down'):
		velocity.y = speed*delta*60
	move_and_slide()
