extends Label

@export var version_number: String


func update_basic_infos(level_name: StringName) -> void:
	text = "cow by Qualia v" + version_number + " lvl:" + level_name
