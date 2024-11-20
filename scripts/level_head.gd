extends Node2D


@export var music: PackedStringArray
var tile_map: TileMapLayer = null


func _ready():
	for child in get_children():
		if child is TileMapLayer:
			tile_map = child


var explosion_particles = preload("res://particles/explosion_particles.tscn")
var lit_tnt = preload("res://creatures/lit_tnt.tscn")


func create_explosion(where: Vector2, size: float):
	
	var particles = explosion_particles.instantiate()
	particles.position = where
	particles.set_size(size)
	add_child(particles)
	
	var center: Vector2 = Vector2(tile_map.local_to_map(where))
	var number_of_rays: int = int(size * 9)
	for i: int in number_of_rays:
		var angle: float = float(i) / number_of_rays * TAU
		shoot_explosion_ray(center, Vector2(cos(angle), sin(angle)), size)


func shoot_explosion_ray(start:Vector2, delta: Vector2, size):
	var strength: float = size
	var current: Vector2 = start
	while true:
		current += delta
		var cell: Vector2i = Vector2i(current)
		var cell_data: TileData = tile_map.get_cell_tile_data(cell)
		
		var resistance: float
		if cell_data == null:
			resistance = 1
		else:
			resistance = cell_data.get_custom_data("explosion_resistance")
		
		if strength < resistance: return
		
		if cell_data != null and cell_data.get_custom_data("tnt"):
			var tnt = lit_tnt.instantiate()
			tnt.position = tile_map.map_to_local(cell)
			tnt.create_explosion.connect(create_explosion)
			add_child(tnt)
		
		tile_map.erase_cell(cell)
		strength -= resistance


func attach_rope(node: Node2D):
	$Rope.attach(node)


func dettach_rope():
	$Rope.deattach()
