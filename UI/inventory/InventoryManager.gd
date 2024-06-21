extends Node


#inventory data structure
var inventory = []

# Initialize inventory with empty slots (assuming a fixed size for simplicity)
func _init():
	inventory.resize(27)


func add_item(ID="0"):
	var item_texture = load("res://Assets/items/" + ItemData.get_texture(ID))
	var item_slot_type = ItemData.get_slot_type(ID)
	var item_ATK = ItemData.get_ATK(ID)
	
	var item_data = { "TEXTURE" : item_texture,
						"ATK" : item_ATK,
						"SLOT_TYPE" : item_slot_type}
						
	
	var index = 0
	for i in get_children(): #traverse through all slots
		if i.filled == false:
			index = i.get_index() #get index of first unfilled slot
			break
	
	get_child(index).set_property(item_data) #add item to that index
