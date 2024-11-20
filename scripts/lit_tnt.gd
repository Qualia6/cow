extends RigidBody2D

signal create_explosion(where: Vector2)

var fuse: float

func _ready():
	fuse = randf()/ 2 + 0.5
	linear_velocity = Vector2.from_angle(randf() * TAU) * 400
	angular_velocity = (randf() - 0.5) * TAU

func _physics_process(delta: float) -> void:
	fuse -= delta
	if fuse <= 0:
		create_explosion.emit(position, 6)
		queue_free()


func what_are_you():
	return "tnt"

func moisten():
	return true
