extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBank.toggleUIVisibility.connect(Callable(self, "toggle_visibility"))
	visible = true


func _input(event):
	if event.is_action_pressed("inventory"):
		visible = !visible


func toggle_visibility():
	visible = !visible
