extends CharacterBody3D

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
		
func face_player(player):

	var direction = player.global_position - global_position

	direction.y = 0

	look_at(
		global_position + direction,
		Vector3.UP
	)
