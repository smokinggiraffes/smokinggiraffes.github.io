extends Node2D

@onready var ui = get_node("PlayerCharacterMain/UIOverlay/DayNightCycleUI")
@onready var sound_machine = $SoundMachine


func _ready():
	var player = get_node("PlayerCharacterMain")
	#check if we are returning from another scene
	if Global.previousScene != "":
		#restore the player's position
		player.position = Global.playerPostion
	
	
	var canvas_layer = get_node("PlayerCharacterMain/UIOverlay")
	var canvas_modulate = get_node("PlayerCharacterMain/CanvasModulate")
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(ui.set_daytime)
	canvas_modulate.time_tick.connect(sound_machine.set_daytime)
