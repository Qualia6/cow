extends RigidBody2D
class_name Draggable

var dragged: bool:
	set(new_value):
		dragged = new_value
		var parent = get_parent()
		if dragged:
			parent.attach_rope(self)
		else:
			parent.dettach_rope()


var grab_pos: Vector2 = Vector2(0,0)


var drag_strength: float = 500
func set_drag_strength(strength: float):
	drag_strength = strength


func _physics_process(_delta):
	if dragged:
		var foward = Vector2(cos(rotation),sin(rotation))
		var sideways = Vector2(sin(rotation),-cos(rotation))
		var mouse_pos = get_viewport().get_mouse_position()
		var relative_mouse = mouse_pos - global_position
		var relative_grab: Vector2 = grab_pos.x * foward + grab_pos.y * sideways
		apply_force(relative_mouse * drag_strength, center_of_mass + relative_grab)


func _input(event):
	if event.is_action_released("press"):
		dragged = false


func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event.is_action_pressed("press"):
		dragged = true
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var relative_mouse: Vector2 = mouse_pos - global_position
		var foward: Vector2 = Vector2(cos(rotation),sin(rotation))
		var sideways: Vector2 = Vector2(foward.y,-foward.x)
		grab_pos = Vector2(relative_mouse.project(foward).length(), relative_mouse.project(sideways).length())


func what_are_you():
	return "idk"


func moisten():
	return true
