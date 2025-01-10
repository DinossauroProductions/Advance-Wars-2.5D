@tool
extends Node3D

@export var BottomMesh : Mesh
@export var TopMesh: Mesh
@export_range(10, 10000000) var tamanhoLado: int = 300

var bottomNode: MultiMeshInstance3D
var topNode: MultiMeshInstance3D

@export var buttonExecute: bool = false:
	set = _executar_editor

func _executar_editor(h):
	buttonExecute = false
	_ready()

func _ready():
	
	bottomNode = %Bottom
	topNode = %Top
	
	setarMesh(topNode, TopMesh, -0.8)
	setarMesh(bottomNode, BottomMesh, -1.6)

func setarMesh(node: MultiMeshInstance3D, mesh: Mesh, height: float):
	# Create the node.multimesh.
	node.multimesh = MultiMesh.new()
	
	
	# Set the format first.
	node.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	# Then resize (otherwise, changing the format is not allowed).
	node.multimesh.instance_count = tamanhoLado * tamanhoLado
	# Maybe not all of them should be visible at first.
	node.multimesh.visible_instance_count = tamanhoLado * tamanhoLado
	
	node.multimesh.mesh = mesh
	
	# Set the transform of the instances.
	for i in range(tamanhoLado):
		for j in range(tamanhoLado):
			
			node.multimesh.set_instance_transform(j + i * tamanhoLado, Transform3D(Basis(), 
			Vector3((i * 2) - tamanhoLado, height, (j * 2) - tamanhoLado)))
