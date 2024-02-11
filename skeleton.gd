extends CharacterBody2D

@export var speed = 40
@export var path: PathFollow2D

func _physics_process(delta):
	path.progress_ratio += 0.0001 * speed
