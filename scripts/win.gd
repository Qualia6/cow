extends Node2D

var music = []

func _ready() -> void:
	var result: String = "Times for each level:\n"
	var level_times: Array = get_tree().current_scene.level_times
	for i in (level_times.size() - 1):
		result += str(roundf(level_times[i+1]*100)/100) + "\n"
	$times.text = result
	
	result = "Number of Restarts\nfor each level:\n"
	var restart_counts: Array = get_tree().current_scene.restart_counts
	for i in (restart_counts.size() - 1):
		result += str(restart_counts[i+1]) + "\n"
	$restarts.text = result
