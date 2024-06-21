extends Control

@onready var inventory_hotbar = $inventory_hotbar_ui

func _ready():
	visible = !visible

func _input(event):
	if event.is_action_pressed("inventory"):
		visible = !visible



