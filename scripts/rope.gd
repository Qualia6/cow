extends Line2D

var sim_points: PackedVector2Array
var point_velcoities: PackedVector2Array


func _ready() -> void:
	visible = false
	sim_points = [
		Vector2(0,0),Vector2(50,0),Vector2(100,0),Vector2(150,50),Vector2(150,150)
	]
	point_velcoities = [
		Vector2(0,0),Vector2(0,0),Vector2(0,0)
	]
	
	points = [
		Vector2(0,0),Vector2(0,0),
		Vector2(0,0),Vector2(0,0),
		Vector2(0,0),Vector2(0,0),
		Vector2(0,0),Vector2(0,0),
	]


func update_points():
	for i in (sim_points.size() - 2):
		var a: Vector2 = sim_points[i]
		var b: Vector2 = sim_points[i+1]*2
		var c: Vector2 = sim_points[i+2]
		points[i*2+1] = (a*4+b+c*3)/9
		points[i*2+2] = (a*3+b+c*4)/9
	#
	points[0] = sim_points[0]
	points[points.size()-1] = sim_points[sim_points.size()-1]


func _process(delta: float) -> void:
	if visible:
		if !is_instance_valid(rope_attached_to):
			deattach()
			return
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		sim_points[0] = rope_attached_to.position
		sim_points[sim_points.size()-1] = mouse_pos
		
		const damp: float = 2
		const force: float = 1000
		
		for i in (sim_points.size() - 2):
			var affect: Vector2 = point_velcoities[i] * delta
			sim_points[i+1] += affect
			point_velcoities[i] -= affect * damp
			
		for i in (sim_points.size() - 2):
			var desired_location: Vector2 = (sim_points[i] + sim_points[i+2]) / 2
			var offset: Vector2 = desired_location - sim_points[i+1]
			point_velcoities[i] += offset * delta * force
		
		update_points()


func deattach():
	visible = false


var rope_attached_to: Node2D = null


func attach(node: Node2D):
	rope_attached_to = node
	visible = true
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	sim_points.fill(mouse_pos)
	points.fill(mouse_pos)
	point_velcoities.fill(Vector2(0,0))
