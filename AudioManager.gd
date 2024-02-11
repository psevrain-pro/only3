extends Node

var num_players = 8
var bus = "master"
var music_player: AudioStreamPlayer

var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = bus
	
	play_music("res://sounds/soundtrack1.mp3", -15.0)

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)

func play(sound_path):
	queue.append(sound_path)

func _process(delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()

func play_music(sound_path, db):
	music_player.stream = load (sound_path)
	music_player.connect("finished", Callable(self,"_on_loop_sound").bind(music_player))
	music_player.play()
	music_player.set_volume_db(db)

func _on_loop_sound(player):
	music_player.stream_paused = false
	music_player.play()

