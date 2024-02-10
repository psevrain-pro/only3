extends Node2D
var tick = 0
var safe = true
var mode = "START"

# Called when the node enters the scene tree for the first time.
func _ready():
	for cpt in range (3,0, -1):
		$HMI/Message.text = str(cpt)
		await get_tree().create_timer(0.7).timeout
	$Player.mode = "PLAY"
	$HMI/Message.text = ""
	mode = "PLAY"
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

func game_over():
	$Player.die()
	await get_tree().create_timer(0.7).timeout
	# son
	$HMI/Message.text = "Game Over"
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()

func _on_timer_timeout():
	tick += 1
	$HMI/Tick.text = str(tick)
	if tick >= 3:
		fire()
		tick = 0
