extends CharacterBody3D

@export var npc_id: String = "npc_default"
@export var npc_name: String = "NPC"

var dialogue = [
	"Hola aventurero",
	"Bienvenido al pueblo",
	"Espero que disfrutes tu estancia"
]

func interact(player):
	face_player(player)

	var ui = get_tree().get_first_node_in_group("ui")

	if ui:
		ui.start_dialogue(dialogue)
		GameEvents.npc_visited.emit(npc_id)

func face_player(player):
	var direction = player.global_position - global_position
	direction.y = 0
	look_at(
		global_position + direction,
		Vector3.UP
	)
