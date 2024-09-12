extends CharacterBody2D

@onready var projectile_emmiter = $ProjectileEmmiter
@onready var static_arrow = $StaticArrow
@onready var bow = $Sprite2D
var speed = 200
var frame = 0
var angle = 0
var wobble = 0
var toggle = true
var count = 0
@onready var arrow_texture = preload("res://arrow.png")
var arrow = preload('res://Arrow.tscn')
var offset = [-24 ,-18,-12,-6,0,6,-12,-18]

func _ready():
	pass
func _physics_process(delta: float):
	#reset var
	velocity.x = 0
	
	#inputs
	#movement of bow
	
	if Input.is_action_pressed('ui_left') and position.x > 0:
		velocity.x = -speed*delta*60
	if Input.is_action_pressed('ui_right') and position.x< 600:
		velocity.x = speed*delta*60
	#shooting
	
	if Input.is_action_pressed('ui_accept'):
		static_arrow.texture = arrow_texture
		static_arrow.visible = true
		if not frame == 5:
			frame += 10 * delta
		#wobble
		if wobble < 3:
			wobble += 0.5 * delta
		else:
			wobble = 3
		if toggle:
			angle +=  wobble
		else:
			angle -= wobble
		if angle >= wobble*4:
			toggle = false
		if angle <= -wobble*4:
			toggle = true
		

	
	elif not frame == 0:
		frame += 1
		
		
	if Input.is_action_just_released('ui_accept'):
		static_arrow.visible = false
		
		if frame >3  and frame<7:
			angle += 270
			projectile_emmiter.shoot(4,1,angle,300*frame**3,global_position,5,arrow)
		angle = 0
		wobble = 0
	
	if frame > 7:
		frame = 0
	bow.frame = frame
	static_arrow.offset.y = offset[frame]
	bow.rotation_degrees = angle
	static_arrow.rotation_degrees = angle
	
	move_and_slide()
