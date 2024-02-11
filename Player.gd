extends CharacterBody2D

var speed = 70.0
var mode = "WAIT"
var push_force = 20

func _physics_process(delta):
	if mode == "PLAY":
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		move_and_slide()

func whoami():
	return "player"

func die():
	mode = "DIE"
	$AnimatedSprite2D.play("die")
	#await get_tree().create_timer(0.7).timeout
	#queue_free()
