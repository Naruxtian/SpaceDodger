extends Area2D

export(int)var Velocidad
var Movimiento  
var Limite
signal golpe

func _ready():
	#Esconder el personaje para la pantalla de titulo
	hide()
	#Establecer como limite la pantalla
	Limite = get_viewport_rect().size

func _process(delta):
	#Movimientos
	Movimiento = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		Movimiento.x +=1
	
	if Input.is_action_pressed("ui_left"):
		Movimiento.x -=1
	
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -=1
	
	if Input.is_action_pressed("ui_down"):
		Movimiento.y +=1
	
	#Hacer que no vaya mas rapido en diagonal
	if Movimiento.length() > 0: #Verifica si se está moviendo
		Movimiento = Movimiento.normalized() * Velocidad #Normalizar la velocidad
	
	#Actualizar movimientos
	position += Movimiento * delta
	#Limitar para que no se salga de la pantalla
	position.x = clamp(position.x, 0, Limite.x)
	position.y = clamp(position.y, 0, Limite.y)
	
	#Animaciones
	if Movimiento.x != 0:
		$AnimationPlayer.play("GiroUfo")
		$Sprite.flip_h = Movimiento.x < 0
	elif Movimiento.y != 0:
		$AnimationPlayer.play("GiroUfo")
		$Sprite.flip_v = Movimiento.y < 0

#Golpes con obstaculos
func _on_Player_body_entered(body):
	hide()
	emit_signal("golpe")
	$CollisionShape2D.disabled = true
	
func inicio(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
