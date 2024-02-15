extends Node2D
var tick = 0
var safe = true
var mode = "START"
var flashRect: ColorRect

@export var title: String =""
@export var next_scene: String =""

# Called when the node enters the scene tree for the first time.
func _ready():
	initFlashRect()
	$HMI.show()
	$HMI.display_title(title)
	for cpt in range (3,0, -1):
		$HMI/Message.text = str(cpt)
		await get_tree().create_timer(0.7).timeout
	$Player.mode = "PLAY"
	$HMI/Message.text = ""
	mode = "PLAY"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	safe = false
	for p in $Pentacles.get_children():
		if p.overlaps_body($Player):
			safe = true
	if mode=="PLAY" and $Timer.is_stopped() and safe==false:
		tick = 0
		ring_bell()
		$Timer.start()

func fire():
	#flash
	AudioManager.play("res://sounds/flash.mp3")
	AudioManager.play("res://sounds/bell2.mp3")
	for p in $Pentacles.get_children():
		p.fire()
	if not safe:
		flash(Color.RED)
		game_over()
	else :
		pentacle_reached()

func level_ok():
	$Player.mode = "WAIT"
	mode = "WAIT"
	$Timer.stop()
	AudioManager.play("res://sounds/fin_level.wav")
	await get_tree().create_timer(2.0).timeout
	if len(next_scene) == 0:
		$HMI/Message.text = "You Win !!!"
	else :
		flash(Color.WHITE)
		get_tree().change_scene_to_file(next_scene)

func pentacle_reached():
	flash(Color.LIME_GREEN)
	AudioManager.play("res://sounds/magic-1s.mp3")
	$Timer.stop()

func game_over():
	mode = "WAIT"
	$Timer.stop()
	$Player.die()
	await get_tree().create_timer(0.7).timeout
	AudioManager.play("res://sounds/die.mp3")
	AudioManager.play("res://sounds/orgue_mort.wav")
	$HMI/Message.text = "Game Over"
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()

func _on_timer_timeout():
	tick += 1
	if tick > 2:
		fire()
		tick = 0
	else:
		ring_bell()
		
func ring_bell():
	flash(Color.WHITE)
	AudioManager.play("res://sounds/bell1.mp3")

func initFlashRect():
	flashRect = ColorRect.new()
	flashRect.size = get_viewport().get_visible_rect().size
	flashRect.z_index = RenderingServer.CANVAS_ITEM_Z_MAX
	flashRect.hide()
	add_child(flashRect)

func flash(color: Color):
	var tween = create_tween()
	flashRect.show()
	flashRect.color=color
	flashRect.modulate.a = 0.50
	tween.tween_property(flashRect, "modulate:a", 0.0, 0.25)
	await tween.finished
	flashRect.hide()
	
	
