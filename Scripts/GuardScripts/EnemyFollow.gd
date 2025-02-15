extends State
class_name Enemy_Follow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0

var player : CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
		
	if direction.length() <= 25:
		player.global_position = PlayerVariables.spawn_coords
	
	if direction.length() > 100:
		Transitioned.emit(self, "Idle")
