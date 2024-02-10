extends CharacterBody2D

var speed = 150.0
var mode = "WAIT"
var push_force = 20

func _physics_process(delta):
	if mode == "PLAY":
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		move_and_slide()
	#for i in get_slide_collision_count():
		#var c = get_slide_collision(i)
		#if c.get_collider() is RigidBody2D:
			#c.get_collider().apply_central_impulse(-c.get_normal() * push_force)


func die():
	mode = "DIE"
	$AnimatedSprite2D.play("die")
	#await get_tree().create_timer(0.7).timeout
	#queue_free()
