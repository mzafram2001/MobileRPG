extends Node

const BattleUnits = preload("res://BattleUnits.tres")

var max_hp = 25
var hp = max_hp setget set_hp
var max_ap = 3
var ap = max_ap setget set_ap
var max_mp = 10
var mp = max_mp setget set_mp

# LEVELING SYSTEM
signal experience_gained(growth_data)

export (int) var level = 1
var experience = 0
var experience_total = 0
var experience_required = get_required_experience(level + 1)

signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)
signal end_turn

func set_hp(value):
	hp = clamp(value, 0, max_hp)
	emit_signal("hp_changed", hp, max_hp)

func set_ap(value):
	ap = clamp(value, 0, max_ap)
	emit_signal("ap_changed", ap, max_ap)
	if ap == 0:
		emit_signal("end_turn")

func set_mp(value):
	mp = clamp(value, 0, max_mp)
	emit_signal("mp_changed", mp, max_mp)

func _ready():
	BattleUnits.PlayerStats = self

func _exit_tree():
	BattleUnits.PlayerStats = null


# LEVELING SYSTEM
func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4)

func gain_experience(amount):
	experience_total += amount
	experience += amount
	var growth_data = []
	while experience >= experience_required:
		experience -= experience_required
		growth_data.append([experience_required, experience_required])
		level_up()
	growth_data.append([experience, experience_required])
	emit_signal("experience_gained", growth_data)

func  level_up():
	level += 1
	experience_required = get_required_experience(level + 1)
	
	var stats = ['max_hp', 'max_mp']
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + randi() % 4 + 2)
