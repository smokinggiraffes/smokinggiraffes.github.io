extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var slot_machine_ui = get_node('UIOverlay/slot_machine_ui')

var interact: Callable = func():
	pass



# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	slot_machine_ui.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_interact():
	if(slot_machine_ui.visible):
		slot_machine_ui.visible = false
		SignalBank.toggleUIVisibility.emit()
	else:
		slot_machine_ui.visible = true
		SignalBank.toggleUIVisibility.emit()
	
