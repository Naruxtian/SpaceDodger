extends Node

export (PackedScene) var Obstaculo
var Score

func _ready():
	randomize()
	$Menu.play()
	
func nuevo_juego():
	Score = 0
	$Player.inicio($PosicionDeInicio.position) #Establece la posición de inicio del jugador
	$InicioTimer.start()
	$Interfaz.mostrar_mensaje("PREPARATE!")
	$Interfaz.update_score(Score)
	$Menu.stop()
	$Musica.play()
	$Interfaz/Menu.stop()
	
#Fin del juego
func game_over():
	$ScoreTimer.stop()
	$ObstaculoTimer.stop()
	$Interfaz.game_over()
	$AudioMuerte.play()
	$Musica.stop()
	

#Inicializar los obstaculos y score
func _on_InicioTimer_timeout():
	$ObstaculoTimer.start()
	$ScoreTimer.start()

#Agregar un punto al score segun el timer (cada segundo en este caso)
func _on_ScoreTimer_timeout():
	Score +=1
	$Interfaz.update_score(Score)
	

func _on_ObstaculoTimer_timeout():
	#Selecciona un lugar aleatorio en el path para generar el obstaculo
	$Camino/ObstaculoPosicion.set_offset(randi())
	
	var obst = Obstaculo.instance()
	add_child(obst)
	
	#Seleccionar una dirección
	var direccion = $Camino/ObstaculoPosicion.rotation + PI /2
	
	#Establecemos la generacion del obstaculo en la posicion del camino
	obst.position = $Camino/ObstaculoPosicion.position
	
	#Establece las direcciones del obstaculo
	direccion += rand_range(-PI/4, PI/4)
	obst.rotation = direccion
	obst.set_linear_velocity(Vector2(rand_range(obst.Velocidad_min, obst.Velocidad_max), 0).rotated(direccion))
	
