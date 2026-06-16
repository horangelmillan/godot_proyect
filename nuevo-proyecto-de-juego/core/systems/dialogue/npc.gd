extends CharacterBody3D

@export var npc_id: String = "npc_default"
@export var npc_name: String = "NPC"

var dialogue = [
	"Hola aventurero",
	"Bienvenido al pueblo",
	"Espero que disfrutes tu estancia"
]

var interaction_in_progress = false

func face_player(player):
	var direction = player.global_position - global_position
	direction.y = 0
	look_at(
		global_position + direction,
		Vector3.UP
	)
