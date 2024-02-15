extends PathFollow2D

@export var speed = 0.1

func _physics_process(delta):
	progress_ratio += speed * delta
