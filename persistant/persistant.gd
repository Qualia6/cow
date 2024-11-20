extends Node


var level_times: Array = [INF]
var restart_counts: Array = [0]

func restart():
	var index: int = restart_counts.size()-1
	restart_counts[index] +=1
	$"Level Holder".load_level($"Level Holder".current_level)


func next_level():
	$"Level Holder".load_level($"Level Holder".current_level+1)
	level_times.append(INF)
	restart_counts.append(0)
	

func report_time(time: float):
	var index: int = level_times.size()-1
	if (time < level_times[index]):
		level_times[index] = time
