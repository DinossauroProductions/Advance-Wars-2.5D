@tool
extends Resource

class_name Level_Data

const maxSize : int = 50
const minSize : int = 5 

@export_range(minSize, maxSize, 1, "suffix:Tiles") var sizeX : int = minSize
@export_range(minSize, maxSize, 1, "suffix:Tiles") var sizeY : int = maxSize

@export var pathTile: String
@export var execute_button: bool = false:
	set = _set_execute_button

func _set_execute_button(x):
	#print('aaa')
	execute_button = false
	loadLevelFromString(pathTile)
	
	

# Definido no tamanho mínimo possível
@export var tiles: Array

func loadLevelFromString(path : String):
	
	#print(path)
	
	var string = load_file(path)
	
	# Remove the last "\n" of the file
	var lines = string.split("\n")
	lines.remove_at(lines.size()-1)
	string = "\n".join(lines)
	
	# Check if the map is valid
	if(checkMap(string) == -1):
		return
	
	# Separate by "\n"
	lines = string.split("\n")
	
	sizeY = lines.size()
	
	for i in range(lines.size()):
		
		var ids = lines[i].split(",")
		
		if(i == 0):
			sizeX = ids.size()
			sizeX = ids.size()
		
		#print(ids.size())
		for j in range(ids.size()):
			if(j == 0 and i == 0):
				# when it's the first time iterating, set the size of the tiles 
				# matrix to the input map's size
				tiles = createMatrix(sizeX, sizeY)
			tiles[i][j] = int(ids[j])
	
	
func createMatrix(cols: int, rows: int) -> Array:
	var mat = []
	for ii in range(cols):
		var row = []
		for jj in range(rows):
			row.append(0)
		mat.append(row)
	return mat
	
func load_file(path):
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
	

func checkMap(mapString):
	var lines = mapString.split("\n")
	if(lines.size() - 1 > maxSize or lines.size() - 1 < minSize):
		print("Ilegal map height")
		return -1
	
	var firstLineSize = lines[0].split(",").size()
	for i in range(lines.size()):
		if(lines[i].split(",").size() != firstLineSize):
			print("Inconsistent map width")
			return -1
			
	if(firstLineSize > maxSize or firstLineSize < minSize):
		print("Ilegal map width")
		return -1
	return 0
