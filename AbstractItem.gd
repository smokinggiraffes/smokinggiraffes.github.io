extends Sprite2D

@export var ID = "0"

func _ready():
	texture = load("res://Assets/items/" + ItemData.get_texture(ID))


func _on_area_2d_body_entered(body):
	get_parent().find_child("Inventory").add_item(ID)
	queue_free()
