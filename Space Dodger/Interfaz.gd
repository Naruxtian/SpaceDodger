extends CanvasLayer

signal iniciar_juego

func mostrar_mensaje(texto):
	$Mensaje.text = texto
	$Mensaje.show()
	$MensajeTimer.start()
	
func game_over():
	mostrar_mensaje("Game Over")
	yield($MensajeTimer, "timeout") #Hace que espere 2 segundos (El tiempo definido en el timer) para mostrar lo que sigue
	$Menu.play()
	$BotonPlay.show()
	$Mensaje.text = "Space dodger"
	$Mensaje.show()	
	
func update_score(Puntos):
	$ScoreLabel.text = str(Puntos)


func _on_MensajeTimer_timeout():
	$Mensaje.hide()


func _on_BotonPlay_pressed():
	$BotonPlay.hide()
	emit_signal("iniciar_juego")
	
	
	
