extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Gm.score_change.connect(on_score_change)
	on_score_change(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Score.text = str(Gm.score)
	pass

func display_title(title):
	$Title.text = title

func hello():
	$Transition/AnimationPlayer.play("part")
func good_by():
	$Transition/AnimationPlayer.play("arrive")

func on_score_change(cb):
	$Score.text = str(Gm.score)
