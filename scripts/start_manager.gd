extends Node2D

var timer: float = 1.5


func _ready() -> void:
	timer = 1.5
	$Button.visible = false
	$loading.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer < 0:
		$Button.visible = true
		$loading.visible = false


func _on_button_pressed() -> void:
	get_tree().current_scene.next_level()
