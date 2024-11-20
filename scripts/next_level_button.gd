extends Button


func _ready() -> void:
	visible = false


func _on_goal_zone_done() -> void:
	visible = true


func _on_pressed() -> void:
	get_tree().current_scene.next_level()
