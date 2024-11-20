extends GPUParticles2D

func _ready():
	emitting = true
	one_shot = true

func set_size(size: float):
	amount = int(size * 100)
	$boom.volume_db = log(size)*15-35

func _on_finished() -> void:
	queue_free()
