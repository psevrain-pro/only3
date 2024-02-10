extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fire():
	$AnimatedSprite2D.play()

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.pause
	$AnimatedSprite2D.frame = 0
