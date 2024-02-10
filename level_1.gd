extends Node2D
var tick = 0
var safe = true
var mode = "START"

var bell_1 = preload("res://sounds/bell1.mp3")
var bell_2 = preload("res://sounds/bell2.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	for cpt in range (3,0, -1):
		$HMI/Message.text = str(cpt)
		await get_tree().create_timer(0.7).timeout
	$Player.mode = "PLAY"
	$HMI/Message.text = ""
	mode = "PLAY"
	AudioManager.play("res://sounds/start.mp3")
	$Timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	safe = false
	for p in $Pentacles.get_children():
		if p.overlaps_body($Player):
			safe = true
	if mode=="PLAY" and $Timer.is_stopped() and safe==false:
		tick = 0
		$HMI/Tick.text = "?"
		$Timer.start()

func fire():
	#flash
	AudioManager.play("res://sounds/flash.mp3")
	for p in $Pentacles.get_children():
		p.fire()
	if not safe:
		game_over()
	else :
		$Timer.stop()
		$HMI/Tick.text = "---"

func level_ok():
	$Player.mode = "WAIT"
	$Timer.stop()
	AudioManager.play("res://sounds/level_ok.mp3")

func game_over():
	mode = "WAIT"
	$Timer.stop()
	$Player.die()
	await get_tree().create_timer(0.7).timeout
	AudioManager.play("res://sounds/die.mp3")
	$HMI/Message.text = "Game Over"
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()

func _on_timer_timeout():
	tick += 1
	$HMI/Tick.text = str(tick)
	if tick > 3:
		fire()
		tick = 0
	else :
		AudioManager.play("res://sounds/bell1.mp3")
