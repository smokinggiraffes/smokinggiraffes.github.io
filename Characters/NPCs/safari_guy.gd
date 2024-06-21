extends CharacterBody2D
class_name SafariGuy


@export var move_speed : float = 10
@export var start_direction : Vector2 = Vector2(0, 1)


@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var interaction_area: InteractionArea = $InteractionArea


const lines: Array[String] = [
	"Woah, you startled me!",
	"For a second I thought you we're one of the escaped lions",
	"Now that I look closer, you're just a giraffe!",
	"Anyway, watch out for those guards...",
	"If they catch you out here, they'll send you back to your enclosure",
	"Anyway, I've gotta run, but I have a quick favor to ask",
]
#func _unhandled_input(event):
#	if event.is_action_pressed("interact"):
#		if interaction_area.get_overlapping_bodies().size() > 0:
#			InteractionLabel.hide_label()
#			DialogManager.start_dialog(global_position, lines)
#			sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position


func _ready():
	update_animation_param(start_direction)
	interaction_area.interact = Callable(self, "_on_interact")


func _physics_process(delta):
	update_animation_param(velocity * Vector2(1, -1))

	move_and_slide()
	change_state()


func update_animation_param(velocity : Vector2):
	if (velocity != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", velocity)
		animation_tree.set("parameters/Idle/blend_position", velocity)


func change_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")


func _on_interact():
	DialogManager.start_dialog(global_position - Vector2(-57, -30), lines)
	#sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position.x else f
	await DialogManager.dialog_finished
