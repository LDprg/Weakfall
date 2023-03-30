enum States {
	Build,
	Delete,
	Select,
	None
}

const Tiles = {
	None = Vector2i(-1, -1),
	Grass = Vector2i(0,0),
	Sand = Vector2i(1,0),
	Water = Vector2i(2,0),
	Wall = Vector2i(0,1),
	Ground = Vector2i(1,1),
	Selected = Vector2i(2,1),
}
