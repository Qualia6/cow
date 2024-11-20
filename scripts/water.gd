extends Area2D


func _on_body_entered(body: Node2D):
	if body.has_method("moisten"):
		var play_sound = body.moisten()
		if play_sound:
			$splash.play()
			$particles.emit_at(body.global_position, 50)
