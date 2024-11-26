extends Node

@export var level_data : Level_Data

var gridmap : GridMap

func _ready():
	
	#gridmap = get_node("GridMap")
	#loadMap()
	pass



func setGridmapTile(x, y, ID):
	
	gridmap.set_cell_item(Vector3i(x, 0, y), ID)
	pass


func loadMap():
	
	var mesh_count = gridmap.mesh_library.get_item_list().size()
	
	level_data.loadLevelFromString("res://Assets/Scenes/Levels/ID_Sheet_Map.txt")
	
	print(level_data.sizeX)
	print(level_data.sizeY)
	#print(level_data.tiles)
	
	for i in range(level_data.sizeY):
		for j in range(level_data.sizeX):
			
			setGridmapTile(i, j, level_data.tiles[j][i])
			
