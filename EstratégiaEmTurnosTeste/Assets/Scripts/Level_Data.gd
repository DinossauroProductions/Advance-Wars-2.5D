extends Resource

class_name Level_Data

var sizeX : int
var sizeY : int

static var maxSize : int = 50
static var minSize : int = 5 


# Definido no tamanho mínimo possível
var tiles = []

func loadLevelFromString(path : String):
	
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
	
	
func createMatrix(cols: int, rows: int):
	var mat = []
	for ii in range(cols):
		var row = []
		for jj in range(rows):
			row.append(0)
		mat.append(row)
	return mat
	
func load_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
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
