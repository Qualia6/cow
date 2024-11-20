extends Area2D
class_name GoalZone

@export var eat: Dictionary
var label: Label = null

signal done

func _ready():
	for child in get_children():
		if child is Label:
			label = child
	update_status()


func update_status():
	var result: String = ""
	for key in eat:
		result += str(eat[key]) + " " + key + " remaining\n"
	label.text = result


func play_sound():
	var finished: bool = true
	for key: StringName in eat:
		finished = finished and (eat[key] == 0)
	if finished:
		$tada.play()
		done.emit()
	else:
		$yippee.play()


func _on_body_entered(body: Node2D):
	var result: StringName = body.what_are_you()
	if result in eat and eat[result] > 0:
		body.queue_free()
		eat[result] -= 1
		update_status()
		play_sound()
