extends GridContainer


#signal hotbar_updated

func _ready():
	#var inventory_node = get_node("Inventory_UI")
	var inventory_node = load('res://UI/inventory/ui/inventory_ui.tscn')
	print(inventory_node)
	inventory_node.connect("hotbar_updated", hotbar_updated)


func hotbar_updated():
	print ("hotbar received!")

