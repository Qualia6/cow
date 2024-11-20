extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var time: float = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta;
	emitting = time > 0
	

func emit_at(where: Vector2, count: int):
	time = 0.1;
	amount_ratio = count / time / amount
	position = where
	emitting = true
