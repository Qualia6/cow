extends Node


signal play_music(which: PackedStringArray)
signal update_basic_infos(level_name: StringName)

var current_level: int = -1;
var levels: PackedStringArray = [
	"start",
	"basic_2",
	"tree_2",
	"boomer_2",
	"snail_jail_2",
	"win"
]
var first_level: int = 0



func _ready() -> void:
	load_level(first_level)


func load_level(level_idx: int) -> void:
	var new_level = max(min(level_idx, levels.size() - 1), 0)
	var path: String = "res://levels/" + levels[new_level] + ".tscn"
	
	var level_packed: Resource = load(path)
	if level_packed is not PackedScene:
		push_error("Failed to load level: " + levels[new_level])
		return
	
	var level_instance: Node2D = level_packed.instantiate()
	
	# remove previous level
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	var music: PackedStringArray = level_instance.music
	play_music.emit(music)
	
	update_basic_infos.emit(levels[new_level])
	
	add_child(level_instance)
	current_level = new_level
