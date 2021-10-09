extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

var roomCount = 1
onready var RoomText = $UI/ControlItems/Buttons/PlayerStats/Panel/RoomCount

var KillsCount = 0
onready var KillsText = $UI/ControlItems/Buttons/PlayerStats/Panel/CountKills

var MoneyCount = 0
onready var MoneyText = $UI/ControlItems/Buttons/PlayerStats/Panel/MoneyCount

var Experience = 0
onready var ExpText = $UI/ControlItems/Buttons/PlayerStats/Panel/ExpCount

var HPCount = 0
onready var HPText = $UI/ControlItems/Buttons/PlayerStats/Panel/HPCount

var APCount = 0
onready var APText = $UI/ControlItems/Buttons/PlayerStats/Panel/APCount

var MPCount = 0
onready var MPText = $UI/ControlItems/Buttons/PlayerStats/Panel/MPCount

onready var roomLabel = $UI/RoomLabel
onready var expLabel = $UI/LVL
onready var playerStats = $PlayerStats
onready var hpLabel = $UI/StatsPanel/StatsContainer/HP
onready var mpLabel = $UI/StatsPanel/StatsContainer/MP
onready var _bar = $UI/TextureProgress

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition
onready var itemButton = $UI/ControlItems/ActionButtonItems

func _ready():
	update_room(roomCount)
	expLabel.update_text(playerStats.level, playerStats.experience, playerStats.experience_required)
	_bar.initialize(playerStats.experience, playerStats.experience_required)
	randomize()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy != null:
		enemy.connect("died", self, "_on_Enemy_died")

func start_enemy_turn():
	battleActionButtons.hide()
	itemButton.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()

func start_player_turn():
	battleActionButtons.show()
	itemButton.show()
	playerStats = BattleUnits.PlayerStats
	APCount = (playerStats.max_ap-playerStats.ap)+APCount
	playerStats.ap = playerStats.max_ap
	update_ap(APCount)
	yield(playerStats, "end_turn")
	start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()
	itemButton.hide()
	playerStats.gain_experience(50)
	expLabel.update_text(playerStats.level, playerStats.experience, playerStats.experience_required)
	Experience = playerStats.experience + Experience
	update_exp(Experience)
	MoneyCount =  round(rand_range(10,200)) + MoneyCount
	update_money(MoneyCount)
	hpLabel.text = "HP\n"+str(playerStats.hp)+"/"+str(playerStats.max_hp)
	mpLabel.text = "MP\n"+str(playerStats.mp)+"/"+str(playerStats.max_mp)
	KillsCount = KillsCount+1
	update_kills(KillsCount)

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	roomCount = roomCount + 1
	update_room(roomCount)
	animationPlayer.play("FadeToNewRoom")
	yield(get_tree().create_timer(0.3), "timeout")
	roomLabel.text = "Room "+ str(roomCount)
	yield(animationPlayer, "animation_finished")
	APCount = (playerStats.max_ap-playerStats.ap)+APCount
	update_ap(APCount)
	MPCount = (playerStats.mp)+MPCount
	update_mp(MPCount)
	HPCount = (playerStats.hp)+HPCount
	update_hp(HPCount)
	
	playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	itemButton.show()
	create_new_enemy()

func update_kills(KillsCount):
	KillsText.text = "KILLS "+str(KillsCount)

func update_money(Money):
	MoneyText.text = "MONEY "+str(Money)

func update_hp(HPCount):
	HPText.text = "HP "+str(HPCount)

func update_exp(experience):
	ExpText.text = "EXP "+str(experience)

func update_ap(APCount):
	APText.text = "AP "+str(APCount)

func update_mp(MPCount):
	MPText.text = "MP "+str(MPCount)

func update_room(roomCount):
	RoomText.text = "ROOM "+str(roomCount)
