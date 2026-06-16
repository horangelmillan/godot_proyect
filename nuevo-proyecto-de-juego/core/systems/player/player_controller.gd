extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 2
var interaction_distance = 1.5
var last_interaction_time = 0.0
var interaction_cooldown = 0.2

func handle_interaction():
	# Proteger contra múltiples presiones rápidas
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_interaction_time < interaction_cooldown:
		return
	last_interaction_time = current_time

	var ui = get_tree().get_first_node_in_group("ui")

	if ui and ui.is_dialogue_open():
		# Si se está escribiendo, completar el texto inmediatamente
		if ui.is_typing:
			ui.skip_typing = true
		else:
			ui.next_dialogue()
	else:
		try_interact()

func try_interact():
	var npcs = get_tree().get_nodes_in_group("npc")

	for npc in npcs:
		var distance = global_position.distance_to(npc.global_position)

		if distance < interaction_distance:
			npc.interact(self)
			GameManager.visit_npc(npc.npc_id)
			return

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("interact"):
		handle_interaction()

	var ui = get_tree().get_first_node_in_group("ui")

	if ui and ui.is_dialogue_open():
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	GameManager.player_data["position"] = global_position
	GameEvents.player_moved.emit(global_position)
