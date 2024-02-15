extends Area2D

func _on_body_entered(body):
	if body.has_method("whoami") and body.whoami() == "player":
		$AnimatedSprite2D.play("open")
		Gm.score += 100
		Gm.score_change.emit(100)
		get_parent().level_ok()
