extends CharacterBody2D

@onready var projectile_emmiter = $ProjectileEmmiter
var speed = 200

var arrow_texture = preload("res://arrow.png")

func _ready():
	pass
func _physics_process(delta: float):
	#reset var
	velocity.y = 0
	#inputs
	if Input.is_action_pressed('ui_up'):
		velocity.y = -speed*delta*60
	if Input.is_action_pressed('ui_down'):
		velocity.y = speed*delta*60
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		projectile_emmiter.shoot(4,1,2,50000,position,5,arrow_texture)
	move_and_slide()
