extends MultiMeshInstance3D

@export var BottomMesh : Mesh
@export var TopMesh: Mesh
@export var top: bool


func _ready():
	# Create the multimesh.
	multimesh = MultiMesh.new()
	
	
	# Set the format first.
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	# Then resize (otherwise, changing the format is not allowed).
	multimesh.instance_count = 10000
	# Maybe not all of them should be visible at first.
	multimesh.visible_instance_count = 10000
	
	var height
	
	if top:
		height = -0.8
		multimesh.mesh = TopMesh
	else:
		height = -1.6
		multimesh.mesh = BottomMesh
	

	# Set the transform of the instances.
	for i in range(100):
		for j in range(100):
			
			multimesh.set_instance_transform(j + i * 100, Transform3D(Basis(), 
			Vector3((i * 2) - 100, height, (j * 2) - 100)))

			
