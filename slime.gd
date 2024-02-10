extends CharacterBody2D

@export var speed = 40
var destination

func _ready():
	_new_destination()

func _physics_process(delta):
	if (destination - position).length() > 0.5:
		var velocity = (destination - position).normalized() * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			_on_collision(collision)
	else :
		_new_destination()
		speed = 30 + randi()%20

func _new_destination():
	destination = Vector2(randi()%200, randi()%200)

func _on_collision(collision):
	_new_destination()
