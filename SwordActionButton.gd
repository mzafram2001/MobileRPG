extends "res://ActionButton.gd"

const Slash = preload("res://Slash.tscn")
var causedDamage = 0
onready var CausedDamageText = get_parent().get_parent().get_node("ControlItems/Buttons/PlayerStats/Panel/DamageCausedCount")

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null:
		create_slash(enemy.global_position)
		enemy.take_damage(4)
		causedDamage = 4 + causedDamage
		update_caused_damage(causedDamage)
		playerStats.mp += 2
		playerStats.ap -= 1

func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position

func update_caused_damage(causedDamage):
	CausedDamageText.text = "DMGC "+str(causedDamage)
