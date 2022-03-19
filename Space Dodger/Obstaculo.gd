extends RigidBody2D

export(int) var Velocidad_min
export(int) var Velocidad_max
#Array de los tipos de obstaculos
var tipo_obstaculo = ["Naranja", "Rojo", "Azul", "Verde"]

func _ready():
	$AnimatedSprite.animation = tipo_obstaculo[randi() % tipo_obstaculo.size()]
	
	#Para que cada color de obstaculo tenga su propio rastro
	if $AnimatedSprite.animation == "Rojo":
		$RastroRojo.emitting = true
		$RastroNaranja.emitting = false
		$RastroVerde.emitting = false
		$RastroAzul.emitting = false
	
	if $AnimatedSprite.animation == "Naranja":
		$RastroRojo.emitting = false
		$RastroNaranja.emitting = true
		$RastroVerde.emitting = false
		$RastroAzul.emitting = false
	
	if $AnimatedSprite.animation == "Verde":
		$RastroRojo.emitting = false
		$RastroNaranja.emitting = false
		$RastroVerde.emitting = true
		$RastroAzul.emitting = false
	
	if $AnimatedSprite.animation == "Azul":
		$RastroRojo.emitting = false
		$RastroNaranja.emitting = false
		$RastroVerde.emitting = false
		$RastroAzul.emitting = true

#Cuando sale de la pantalla
func _on_Visibilidad_screen_exited():
	queue_free() #Eliminar el objeto
