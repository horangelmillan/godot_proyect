extends Camera3D

@export var player: CharacterBody3D

var exploration_offset = Vector3(0, 5, 5)
var dialogue_offset = Vector3(0, 3, 3)

var current_offset = exploration_offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter_dialogue():

	current_offset = dialogue_offset

func exit_dialogue():

	current_offset = exploration_offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		global_position = player.global_position + current_offset
	pass
