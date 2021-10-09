extends CanvasLayer

func change_scene(scene):
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(scene)
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer,"animation_finished")
	
