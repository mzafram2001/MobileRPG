extends TextureButton

var item : RPGItem setget set_item, get_item
class_name GUIItem

func set_item(_item):
	item = _item
	texture_normal = load(item.texture_path)

func get_item():
	return item

func _ready():
	pass
