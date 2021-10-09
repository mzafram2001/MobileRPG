extends Control

func _ready():
	pass

func _on_TextureButton_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		$Effect.interpolate_property($Buttons, "rect_position", $Buttons.rect_position, $Buttons.rect_position-Vector2(95, 0), 0.25, Tween.EASE_OUT)
		$Effect.start()
	else:
		get_tree().paused = true
		$Effect.interpolate_property($Buttons, "rect_position", $Buttons.rect_position, $Buttons.rect_position+Vector2(95, 0), 0.25, Tween.EASE_OUT)
		$Effect.start()
		yield(get_tree().create_timer(0.10), "timeout")
		get_node("TextureButton").hide()

func _on_Continue_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		$Effect.interpolate_property($Buttons, "rect_position", $Buttons.rect_position, $Buttons.rect_position-Vector2(95, 0), 0.25, Tween.EASE_OUT)
		$Effect.start()
		yield(get_tree().create_timer(0.15), "timeout")
		get_node("TextureButton").show()


func _on_Exit_pressed():
	get_tree().quit()
