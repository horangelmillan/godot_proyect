extends CharacterBody3D

var dialogue = [
	"Hola aventurero",
	"Bienvenido al pueblo",
	"Espero que disfrutes tu estancia"
]

func interact():

	var ui = get_tree().get_first_node_in_group("ui")

	if ui:
		ui.start_dialogue(dialogue)
