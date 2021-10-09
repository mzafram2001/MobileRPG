extends VBoxContainer

var inv : RPGInventory setget set_inv

func _ready():
	pass

func add_gui_item(item : GUIItem):
	$Panel/Grid.add_child(item)

func remove_gui_item(item : GUIItem):
	$Panel/Grid.remove_child(item)
	inv.delete_item(item.item)

func set_inv(inventory : RPGInventory):
	inv = inventory

func _on_AddItem_pressed():
	randomize() 
	var rpgitem = RPGItem.new()
	rpgitem.texture_path = "res://Items/Item" + str(int(round(rand_range(1,5)))) + ".png"
	var guiitem = load("res://GUIItem.tscn").instance()
	guiitem.item = rpgitem
	add_gui_item(guiitem)


func _on_RemoveItem_pressed():
	if $Panel/Grid.get_child_count() > 0:
		remove_gui_item($Panel/Grid.get_children()[0])



