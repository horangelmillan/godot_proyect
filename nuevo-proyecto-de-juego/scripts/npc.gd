extends CharacterBody3D

var dialogue = [
	"Hola aventurero",
	"Bienvenido al pueblo",
	"Espero que disfrutes tu estancia"
]

@export var npc_id: String = "npc_default"
var interaction_in_progress = false

func interact(player):
	# Prevenir múltiples interacciones simultáneas
	if interaction_in_progress:
		return

	interaction_in_progress = true
	face_player(player)

	var ui = get_tree().get_first_node_in_group("ui")

	if ui:
		ui.start_dialogue(dialogue)
		GameEvents.npc_visited.emit(npc_id)

		# Esperar a que el diálogo se cierre
		while ui.dialogue_open:
			await get_tree().create_timer(0.1).timeout

		
		
func face_player(player):

	var direction = player.global_position - global_position

	direction.y = 0

	look_at(
		global_position + direction,
		Vector3.UP
	)
