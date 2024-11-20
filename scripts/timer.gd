extends Label


var time: float = 0;
var tick: bool = true


func _ready() -> void:
	time = 0
	tick = true


func _process(delta: float) -> void:
	if tick: time += delta
	text = "Time: " + str(floor(time*100)/100)


func _on_goal_zone_done() -> void:
	tick = false
	get_tree().current_scene.report_time(time)
