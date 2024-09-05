extends CharacterBody2D

@onready var projectile_emmiter = $ProjectileEmmiter
@onready var static_arrow = $StaticArrow
var speed = 200

@onready var arrow_texture = preload("res://arrow.png")


func _ready():
	pass
func _physics_process(delta: float):
	#reset var
	velocity.y = 0
	
	#inputs
	#movement of bow
	if Input.is_action_pressed('ui_up'):
		velocity.y = -speed*delta*60
	if Input.is_action_pressed('ui_down'):
		velocity.y = speed*delta*60
	#shooting
	
	if Input.is_action_pressed('ui_accept'):
		static_arrow.texture = arrow_texture
		static_arrow.visible = true
	if Input.is_action_just_released('ui_accept'):
		static_arrow.visible = false
		projectile_emmiter.shoot(4,1,2,20000,global_position,5,arrow_texture)
		
	move_and_slide()
