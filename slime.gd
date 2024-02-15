extends CharacterBody2D

@export var speed = 40
var destination

func _ready():
	_new_destination()

func _physics_process(delta):
	if (destination - position).length() > 0.5:
		var velocity = (destination - position).normalized() * speed
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		var collision = move_and_collide(velocity * delta)
		if collision:
			_on_collision(collision)
	else :
		_new_destination()
		speed = 30 + randi()%20
		


func _new_destination():
	destination = Vector2(randi()%600, randi()%400)

func _on_collision(collision):
	_new_destination()
