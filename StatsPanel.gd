extends Panel

onready var hpLabel = $StatsContainer/HP
onready var apLabel = $StatsContainer/AP
onready var mpLabel = $StatsContainer/MP

onready var attackActionButtonsNode = get_parent().get_parent().get_node("UI/BattleActionButtons/SwordActionButton")
onready var healActionButtonsNode = get_parent().get_parent().get_node("UI/BattleActionButtons/HealActionButton")

func _on_PlayerStats_hp_changed(value1, value2):
	if value1 <= 0:
		hpLabel.text = "HP\n"+str(value1)+"/"+str(value2)
		attackActionButtonsNode.hide()
		healActionButtonsNode.hide()
		yield(get_tree().create_timer(0.08), "timeout")
		Global.change_scene("res://GameOver.tscn")
	else:
		hpLabel.text = "HP\n"+str(value1)+"/"+str(value2)

func _on_PlayerStats_ap_changed(value1, value2):
	apLabel.text = "AP\n"+str(value1)+"/"+str(value2)

func _on_PlayerStats_mp_changed(value1, value2):
	mpLabel.text = "MP\n"+str(value1)+"/"+str(value2)
