extends CharacterBody2D

const Const = preload("res://scripts/Constants.gd")

@export var movement_speed: float = 1000
@export var target : Vector2
@export var map : TileMap

var aStar = AStar2D.new()
var path :  PackedVector2Array 

const Directions = [1, 2, 5, 6, 9, 10, 13, 14]

func _ready():
	set_target(position/ map.scale)
	var cells = map.get_used_cells(0)
	
	for cell in cells:
		aStar.add_point(genID(cell), cell)
		
	for cell in cells:
		for dir in Directions:
			var next = map.get_neighbor_cell(cell, dir)	
			if map.get_cell_source_id(0, next) != -1 and map.get_cell_atlas_coords(0, next) != Const.Tiles.Water and map.get_cell_atlas_coords(1, next) != Const.Tiles.Wall:
				aStar.connect_points(genID(cell), genID(next), false)

func _process(_delta):		
	if aStar.has_point(genID(map.local_to_map(target / map.scale))):
		path = aStar.get_point_path(genID(map.local_to_map(position/ map.scale)), genID(map.local_to_map(target/ map.scale)))
		
	if path != null and path.size() > 1:
		var new_velocity: Vector2 = to_local(map.map_to_local(path[1]) * map.scale)
		new_velocity = new_velocity.normalized() * map.scale
		new_velocity *= movement_speed
		
		set_velocity(new_velocity)
		move_and_slide()
	else:
		set_velocity(Vector2.ZERO)
	
	queue_redraw()
	
func _draw():
	draw_circle(to_local(target), 4, Color.RED)
	draw_circle(to_local(position), 4, Color.BLUE)
	
	if path.size() > 0:
		var last = path[0]
		for point in path:
			draw_line(to_local(map.map_to_local(last)*map.scale), to_local(map.map_to_local(point)*map.scale), Color.VIOLET, 2)
			last = point
	
func set_target(pos):
	target = pos
	
func genID(Cell):
	var x = Cell.x + map.get_used_rect().size.x
	var y = Cell.y + map.get_used_rect().size.y
	var id = ((x + y) * (x + y + 1) / 2 + y)
	return id
