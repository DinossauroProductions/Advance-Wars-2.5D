extends GridMap

var selecao: Vector3i

var idSelection: int

func _ready():
	
	idSelection = mesh_library.find_item_by_name("Selection")
	
	assert(idSelection != -1, "Mesh de seleção não encontrada na MeshLibrary")

func setSelection(novaSelecao):
	
	print(novaSelecao + Vector3i(0, 1, 0))
	
	if selecao != null:
		set_cell_item(selecao + Vector3i(0, 1, 0), -1)
	set_cell_item(novaSelecao + Vector3i(0, 1, 0), idSelection)
	selecao = novaSelecao
