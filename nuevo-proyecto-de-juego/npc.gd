extends CharacterBody3D

func interact():

	var ui = get_tree().get_first_node_in_group("ui")

	if ui:
		ui.show_dialogue("Hola aventurero")
