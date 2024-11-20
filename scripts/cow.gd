extends Draggable
var wet: bool = false


func _on_input_event(viewport, event: InputEvent, shape_idx):
	super(viewport, event, shape_idx)


func _ready():
	set_drag_strength(220)
	$Image.frame = 0


func _physics_process(delta):
	super(delta)
	const speed: float = 1500
	var foward = Vector2(cos(rotation),sin(rotation))
	var sideways = Vector2(sin(rotation),-cos(rotation))
	var offset = sideways * 10 + foward * 100
	apply_force(foward * speed, center_of_mass + offset)


func _on_body_entered(_body):
	$moo.volume_db = log(linear_velocity.length())*9 - 60
	$moo.play()
	
	
func what_are_you():
	if wet: return "wet cow"
	else: return "cow"


func moisten():
	if wet: return true
	wet = true
	$Image.frame= 1
	return true
