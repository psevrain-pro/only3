extends CharacterBody2D

var speed = 150.0
var mode = "WAIT"

func _physics_process(delta):
	if mode == "PLAY":
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed
		move_and_slide()


func die():
	mode = "DIE"
	$AnimatedSprite2D.play("die")
	#await get_tree().create_timer(0.7).timeout
	#queue_free()
