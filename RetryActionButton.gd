extends "res://ActionButton.gd"

func _ready():
	pass


func _on_RetryActionButton_pressed():
	Global.change_scene("res://Menu.tscn")
