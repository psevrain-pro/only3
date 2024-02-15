extends Area2D

func _on_body_entered(body):
	if body.has_method("whoami") and body.whoami() == "player":
		Gm.score += 10
		Gm.score_change.emit(10)
		AudioManager.play("res://sounds/coin.mp3")
		queue_free()
