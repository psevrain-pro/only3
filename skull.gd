extends CharacterBody2D

@export var speed = 30
var player 
var level

func _ready():
	player = get_node("/root/Level/Player")
	level = get_node("/root/Level")

func _physics_process(delta):
	if not level.safe:
		velocity = (player.global_position - global_position).normalized() * speed
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		move_and_slide()
		



