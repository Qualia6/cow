extends RigidBody2D


func _physics_process(delta):
	const speed: float = 1500
	var foward = Vector2(cos(rotation),sin(rotation))
	var offset = foward * 100
	apply_force(foward * speed, center_of_mass + offset)


func what_are_you():
	return "snail"


func moisten():
	return true
