extends Node3D

# Controle de Movimentação
@export var cameraSpeed : float = 20
var direção : Vector3 = Vector3.ZERO
var velocidade : Vector3 = Vector3.ZERO
var castNode: RayCast3D 

# Controle de Input
var left = 0
var up = 1
var right = 2
var down = 3

@export_flags_2d_physics var collision_layers: int

var inputs: Array[bool] = [false, false, false, false]
var mouseClicado: bool = false

enum ModoDeInput{
	TECLADO,
	JOYSTICK
}

var camera: Camera3D

var modoDeInput : ModoDeInput = ModoDeInput.TECLADO;


# Called when the node enters the scene tree for the first time.
func _ready():
	direção = Vector3.ZERO
	castNode = %PlayerClickCast
	camera = %PlayerCamera
	camera.make_current()
	

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			mouseClicado = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	receberInput()
	processarInput()
	
	# Aplicar velocidade à direção atual
	direção *= (cameraSpeed * delta)
	
	# Aplicar o movimento atual à velocidade
	velocidade = (velocidade + direção) * 0.5
	
	# Aplicar a velocidade à posição atual
	position += velocidade

func processarInput():
	
	direção = Vector3.ZERO
	
	if(modoDeInput == ModoDeInput.TECLADO):
		
		if(mouseClicado):
			mouseClicado = false
			var space_state = get_world_3d().direct_space_state
		
			var mousePos: Vector2 = get_viewport().get_mouse_position()
			#print("MousePos: ",mousePos)
		
			castNode.target_position = camera.project_ray_normal(mousePos) * 100000
			#print("Ray direction: ", castNode.target_position / 100000)
			
			castNode.force_raycast_update()
			
			var castResult = castNode.get_collider()
			
			if castResult != null:
				if castResult.is_in_group("GridCollision"):
					#print("Cast collision point: ",castNode.get_collision_point())
					
					var posicaoProcessada = Vector3i( castNode.get_collision_point() / 2 )
					
					%GridMap.setSelection(posicaoProcessada)
			
			#print("\n\n")
		
		
		
		if(inputs[left]):
			direção += Vector3(-1, 0, 0)
			inputs[left] = false
			
		if(inputs[right]):
			direção += Vector3(1, 0, 0)
			inputs[right] = false
			
		if(inputs[up]):
			direção += Vector3(0, 0, -1)
			inputs[up] = false
			
		if(inputs[down]):
			direção += Vector3(0, 0, 1)
			inputs[down] = false
	
	
	elif(modoDeInput == ModoDeInput.JOYSTICK):
		
		#Implementar controles de joystick!
		pass
		
	direção = direção.normalized()
	


func receberInput():
	if modoDeInput == ModoDeInput.TECLADO:
		
		if Input.is_action_pressed("Move_right"):
			inputs[right] = true
		if Input.is_action_pressed("Move_left"):
			inputs[left] = true
		if Input.is_action_pressed("Move_up"):
			inputs[up] = true
		if Input.is_action_pressed("Move_down"):
			inputs[down] = true
		
