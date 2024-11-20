extends Draggable


signal create_explosion(where: Vector2)


func _ready():
	set_drag_strength(500)


func _on_input_event(viewport, event: InputEvent, shape_idx):
	super(viewport, event, shape_idx)


func _physics_process(delta):
	super(delta)
	const speed: float = 1000
	var foward = Vector2(cos(rotation),sin(rotation))
	var sideways = Vector2(sin(rotation),-cos(rotation))
	var offset = sideways * -100 + foward * -50
	apply_force(foward * speed, center_of_mass + offset)


func what_are_you():
	return "creeper"


func _on_body_exited(body: Node) -> void:
	if linear_velocity.length() > 150:
		create_explosion.emit(position, 10)
		queue_free()
