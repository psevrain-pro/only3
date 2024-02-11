extends CharacterBody2D

@export var ouvert_pendant_s = 1
var opened = true

func _ready():
	close_door()
	$Timer.start()

func _on_timer_timeout():
	if opened:
		close_door()
	else:
		open_door()
	
func open_door():
	$DoorSprite.rotation_degrees=90
	$CollisionShapeOpened.disabled = false
	$CollisionShapeClosed.disabled = true
	opened = true

func close_door():
	$DoorSprite.rotation_degrees=0
	$CollisionShapeOpened.disabled = true
	$CollisionShapeClosed.disabled = false
	opened = false
