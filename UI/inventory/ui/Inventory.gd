extends GridContainer


signal hotbar_updated

var hotbar = []

func get_hotbar():
	# traverse through all slots and get the first 9
	for i in range(9):
		var child = get_index(i)
		hotbar.append(child)


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
	if index < 9:	#if it's a hotbar item
		var hotbar = get_hotbar()	# get hotbar
		hotbar_updated.emit() #send hotbar update signal
	get_child(index).set_property(item_data) #add item to that index
