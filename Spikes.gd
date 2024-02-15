extends StaticBody2D
var blocking = false

@export var time_up = 1.0
@export var time_down = 1.0
@export var time_offset = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(time_offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	blocking = not blocking
	if blocking :
		$AnimatedSprite2D.play("default")
		$Timer.start(time_up)
	else :
		$AnimatedSprite2D.play_backwards("default")
		$Timer.start(time_down)
	$CollisionShape2D.disabled = not blocking
	
