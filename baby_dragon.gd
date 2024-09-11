extends CharacterBody2D

@onready var baby_dragon = $BD_animation

func _physics_process(delta : float):
	baby_dragon.play('default',100*delta)
