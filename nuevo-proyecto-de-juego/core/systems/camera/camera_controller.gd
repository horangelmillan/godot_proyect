extends Camera3D

@export var player: CharacterBody3D

var exploration_offset = Vector3(0, 5, 5)
var dialogue_offset = Vector3(0, 3, 3)
var follow_speed = 5.0

var current_offset = exploration_offset

func enter_dialogue():
	current_offset = dialogue_offset

func exit_dialogue():
	current_offset = exploration_offset

func _process(delta: float) -> void:
	if player:
		var target_position = player.global_position + current_offset

		global_position = global_position.lerp(
			target_position,
			delta * follow_speed
		)

		look_at(
			player.global_position,
			Vector3.UP
		)
