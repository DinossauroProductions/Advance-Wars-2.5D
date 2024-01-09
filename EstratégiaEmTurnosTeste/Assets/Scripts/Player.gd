extends Node3D

# Controle de Movimentação
var speed : float = 260
var direção : Vector3 = Vector3.ZERO
var velocidade : Vector3 = Vector3.ZERO

# Controle de Input
var left = 0
var up = 1
var right = 2
var down = 3

var inputs = [false, false, false, false]

enum ModoDeInput{
	TECLADO,
	JOYSTICK
}

var modoDeInput : ModoDeInput = ModoDeInput.TECLADO;

# Called when the node enters the scene tree for the first time.
func _ready():
	direção = Vector3.ZERO
	
	if is_instance_valid(get_node("Camera")) and get_node("Camera") is Camera3D:
		var camera_node : Camera3D = get_node("Camera")
		camera_node.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	receberInput()
	processarInput()
	
	# Aplicar velocidade à direção atual
	direção *= (speed * delta)
	
	# Aplicar o movimento atual à velocidade
	velocidade = (velocidade + direção) * 0.5
	
	# Aplicar a velocidade à posição atual
	position += velocidade

func processarInput():
	
	direção = Vector3.ZERO
	
	if(modoDeInput == ModoDeInput.TECLADO):
		
		if(inputs[left]):
			direção += Vector3(1, 0, 0)
			inputs[left] = false
			
		if(inputs[right]):
			direção += Vector3(-1, 0, 0)
			inputs[right] = false
			
		if(inputs[up]):
			direção += Vector3(0, 0, 1)
			inputs[up] = false
			
		if(inputs[down]):
			direção += Vector3(0, 0, -1)
			inputs[down] = false

	
	elif(modoDeInput == ModoDeInput.JOYSTICK):
		
		#Implementar controles de joystick!
		pass
	


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
		


